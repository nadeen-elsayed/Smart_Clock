#include <MD_Parola.h>
#include <MD_MAX72xx.h>
#include <ThreeWire.h>
#include <RtcDS1302.h>
#include "Font_Data.h"
#include <ESP32Servo.h>
#include <DHT.h>
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <WiFi.h>
#include <Keypad.h>
#include <DHT.h>


#define HARDWARE_TYPE MD_MAX72XX::FC16_HW
#define MAX_DEVICES 4
#define CS_PIN 26
#define DATA_PIN 27
#define CLK_PIN 25
#define buzzerPin 32
#define DHT_SENSOR_PIN 23
#define DHT_SENSOR_TYPE DHT11
#define WIFI_SSID "we home"
#define WIFI_PASSWORD "#100200300#we"
#define API_KEY "AIzaSyALOsA8qrOFBcc5r7FVn_rd6JxxaOsJ3CY"
#define DATABASE_URL "https://iot-project-af3d8-default-rtdb.firebaseio.com/"
#define USER_EMAIL "nadeen@gmail.com"
#define USER_PASSWORD "123456"

Servo servoMain;  // Define our Servo
int trigpin = 17;
int echopin = 34;
int distance;
float duration;
float cm;
ThreeWire myWire(19, 18, 22);  // IO, SCLK, CE
RtcDS1302<ThreeWire> Rtc(myWire);

// create an instance of the MD_Parola class
MD_Parola ledMatrix = MD_Parola(HARDWARE_TYPE, DATA_PIN, CLK_PIN, CS_PIN, MAX_DEVICES);


DHT dht_sensor(DHT_SENSOR_PIN, DHT_SENSOR_TYPE);
// Define the keypad layout
const byte ROWS = 4;  // Number of rows in the keypad
const byte COLS = 4;  // Number of columns in the keypad

char keys[ROWS][COLS] = {
  { '1', '2', '3', 'A' },
  { '4', '5', '6', 'B' },
  { '7', '8', '9', 'C' },
  { '*', '0', '#', 'D' }
};

byte rowPins[ROWS] = { 13, 12, 14, 33 };  // Connect to the row pinouts of the keypad
byte colPins[COLS] = { 21, 15, 4, 5 };    // Connect to the column pinouts of the keypad


FirebaseData fbdo;

/* Define the FirebaseAuth data for authentication data */
FirebaseAuth auth;

/* Define the FirebaseConfig data for config data */
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);
RtcDateTime dt;


void setup() {

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  unsigned long ms = millis();

  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }

  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  auth.user.email = "nadeen@gmail.com";
  auth.user.password = USER_PASSWORD;
  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(4096); 


  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback;  // see addons/TokenHelper.h

  /* Initialize the library with the Firebase authen and config */
  Firebase.begin(&config, &auth);


#if defined(ESP8266)
  // In ESP8266 required for BearSSL rx/tx buffer for large data handle, increase Rx size as needed.
  fbdo.setBSSLBufferSize(2048 /* Rx buffer size in bytes from 512 - 16384 */, 2048 /* Tx buffer size in bytes from 512 - 16384 */);
#endif
  analogWrite(buzzerPin, LOW);
  servoMain.attach(16);  // servo on digital pin 10

  pinMode(trigpin, OUTPUT);
  pinMode(echopin, INPUT);

  dht_sensor.begin();         // initialize the DHT sensor
  ledMatrix.begin();          // initialize the LED Matrix
  ledMatrix.setIntensity(0);  // set the brightness of the LED matrix display (from 0 to 15)
  ledMatrix.displayClear();
  // clear LED matrix display
  // ledMatrix.setFont(dig5x8sq);
  Serial.begin(115200);

  Serial.print("compiled: ");
  Serial.print(__DATE__);
  Serial.println(__TIME__);

  Rtc.Begin();

  RtcDateTime compiled = RtcDateTime(__DATE__, __TIME__);
  printDateTime(compiled);
  Serial.println();

  if (!Rtc.IsDateTimeValid()) {
    Serial.println("RTC lost confidence in the DateTime!");
    Rtc.SetDateTime(compiled);
  }

  if (Rtc.GetIsWriteProtected()) {
    Serial.println("RTC was write protected, enabling writing now");
    Rtc.SetIsWriteProtected(false);
  }

  if (!Rtc.GetIsRunning()) {
    Serial.println("RTC was not actively running, starting now");
    Rtc.SetIsRunning(true);
  }

  RtcDateTime now = Rtc.GetDateTime();
  Serial.println();
}

void loop() {

  int sensorPin = A0;
  int read = analogRead(sensorPin);
  Serial.println(read);

  // read humidity
  float humi = dht_sensor.readHumidity();
  // read temperature in Celsius
  float tempC = dht_sensor.readTemperature();
  // read temperature in Fahrenheit
  float tempF = dht_sensor.readTemperature(true);


  openDoor();
  RtcDateTime now = Rtc.GetDateTime();

  printDateTime(now);
  if (Firebase.ready() && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    Serial.println(auth.token.uid.c_str());
    Serial.println("---------------------");

    // set the readings in firebase
    Serial.printf("Set Temperature Reading... %s\n", Firebase.RTDB.setInt(&fbdo, F("/theReadings/temp"), (int)tempC) ? "ok" : fbdo.errorReason().c_str());
    Serial.printf("Set Humidity Reading... %s\n", Firebase.RTDB.setDouble(&fbdo, F("/theReadings/humi"), humi) ? "ok" : fbdo.errorReason().c_str());

    // get the readings from firebase
    Serial.printf("Get Temperature Reading... %s\n", Firebase.RTDB.getInt(&fbdo, F("/theReadings/temp")) ? String(fbdo.to<double>()).c_str() : fbdo.errorReason().c_str());
    Serial.printf("Get Humidity Reading... %s\n", Firebase.RTDB.getDouble(&fbdo, F("/theReadings/humi")) ? String(fbdo.to<double>()).c_str() : fbdo.errorReason().c_str());
    Serial.printf("Get Hour Reading... %s\n", Firebase.RTDB.getInt(&fbdo, F("/theReadings/hours")) ? String(fbdo.to<double>()).c_str() : fbdo.errorReason().c_str());
    Serial.printf("Get mins Reading... %s\n", Firebase.RTDB.getInt(&fbdo, F("/theReadings/mins")) ? String(fbdo.to<double>()).c_str() : fbdo.errorReason().c_str());

    int hour = Firebase.RTDB.getInt(&fbdo, F("/theReadings/hours")) ? fbdo.to<double>() : 0;
    int mins = Firebase.RTDB.getInt(&fbdo, F("/theReadings/mins")) ? fbdo.to<double>() : 0;
    Serial.println(hour);
    Serial.println(mins);
    setAlarm(now, hour, mins);
    Serial.println();
  }
}

#define countof(a) (sizeof(a) / sizeof(a[0]))

// a function to print sensor values 
void printDateTime(const RtcDateTime& dt) {
  char time[20];
  char date[20];

  snprintf_P(time,
             countof(time),
             PSTR("%02u:%02u"),
             dt.Hour(),
             dt.Minute());
  snprintf_P(date,
             countof(date),
             PSTR("%02u/%02u"),
             dt.Month(),
             dt.Day()

  );
  float humi = dht_sensor.readHumidity();
  // read temperature in Celsius
  float tempC = dht_sensor.readTemperature();
  // read temperature in Fahrenheit
  float tempF = dht_sensor.readTemperature(true);

  // check whether the reading is successful or not
  if (isnan(tempC) || isnan(tempF) || isnan(humi)) {
    Serial.println("Failed to read from DHT sensor!");
  } else {
    Serial.print("Humidity: ");
    Serial.print(humi);
    Serial.print("%");
    Serial.print("  |  ");
    Serial.print("Temperature: ");
    Serial.print(tempC);
    Serial.print("°C  ~  ");
    Serial.print(tempF);
    Serial.println("°F");
  }

  // wait a 2 seconds between readings
  char key = keypad.getKey();
  String tempString = String((int)tempC);
  tempString = "T:" + tempString + "C";
  String humiString = String((int)humi);
  humiString = "H:" + humiString + "%";

  if (key != NO_KEY) {
    // Handle keypress
    if (key == '1') {
      ledMatrix.setTextAlignment(PA_CENTER);
      ledMatrix.print(time);  // display text
    } else if (key == '2') {
      ledMatrix.setTextAlignment(PA_CENTER);
      ledMatrix.print(date);  // display text
    } else if (key == '3') {
      ledMatrix.setTextAlignment(PA_CENTER);
      ledMatrix.print(tempString);

    } else if (key == '4') {
      ledMatrix.setTextAlignment(PA_CENTER);
      ledMatrix.print(humiString);
    }
  }
  Serial.print(date);
}

// function to turn the alarm buzzer on/off
void setAlarm(const RtcDateTime& dt, int hour, int minutes) {
  if (dt.Hour() == hour && dt.Minute() == minutes) {
    Serial.println("High");
    analogWrite(buzzerPin, 127);
    //tone(buzzerPin, 50);
  } else {
    Serial.println("Low");
    analogWrite(buzzerPin, 0);
    //noTone(buzzerPin);
  }
}

// function to a door using a servo
void openDoor() {
  digitalWrite(trigpin, LOW);
  delay(2);
  digitalWrite(trigpin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin, LOW);
  duration = pulseIn(echopin, HIGH);
  cm = (duration / 58.82);
  distance = cm;

  if (distance < 20) {
    servoMain.write(90);  // Turn Servo back to center position (90 degrees)
    delay(3000);
  } else {
    servoMain.write(180);
    delay(50);
  }

}
