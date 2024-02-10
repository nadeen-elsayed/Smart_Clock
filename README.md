## Project Overview: Smart Clock with Firebase Integration

### Description
Our final project is a feature-rich smart clock that seamlessly integrates with a Flutter mobile application through the Firebase Realtime Database. This innovative clock is equipped with various functionalities to enhance the user experience.

### Clock Hardware Components
1. **RTC Module:**
   - Ensures accurate time and date readings.

2. **DHT11 Temperature and Humidity Sensor:**
   - Provides real-time temperature and humidity data.

3. **Buzzer:**
   - Simulates alarm functionality, adding an audible element to the clock.

4. **32x8 LED Matrix:**
   - Displays the current time, date, temperature, and humidity.
   - Navigated using a keypad for user convenience.

### Firebase Realtime Database Integration
- Enables real-time data acquisition.
- Sensors and modules send data to the database.
- Mobile application retrieves and displays the data.
- Allows users to set alarms, updating the database with assigned values.

### Flutter Mobile Application
1. **Sign In Screen:**
   - Authenticates user access to the application.

2. **Sign Up Screen:**
   - Enables new user registration.

3. **Password Reset Screen:**
   - Facilitates password recovery for users.

4. **Sensor Data Screen:**
   - Displays real-time DHT11 sensor readings (humidity and temperature).

5. **Alarm Setting Screen:**
   - Allows users to set alarms seamlessly.
   - Updates the Firebase Realtime Database with user-defined alarm values.

6. **Sign-Out Screen:**
   - Provides a convenient way for users to log out.

### Usage
1. Clone the repository.
2. Set up Firebase credentials.
3. Install dependencies for both the clock firmware and the Flutter app.
4. Upload the clock firmware to the microcontroller.
5. Run the Flutter app on a mobile device.


