import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:modernlogintute/config/router/router.dart';
import 'package:modernlogintute/config/router/router_constants.dart';
import 'package:modernlogintute/config/themes.dart';
import 'package:modernlogintute/view-model/theme_provider.dart';
import 'package:modernlogintute/view-model/weather_provider.dart';

Query dbRef = FirebaseDatabase.instance.ref().child('theReadings/humi');
DatabaseReference reference = FirebaseDatabase.instance.ref().child('theReadings/humi');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ListenableProvider<WeatherProvider>(create: (_) => WeatherProvider()),
      ListenableProvider<ThemeProvider>(create: (_) => ThemeProvider()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'modernlogintute',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.themMode,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: splashRoute,
        );
      },

    );
  }
}

