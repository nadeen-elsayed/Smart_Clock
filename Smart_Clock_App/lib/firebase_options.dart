// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALOsA8qrOFBcc5r7FVn_rd6JxxaOsJ3CY',
    appId: '1:610335358292:web:2845458c4f93b084485cc1',
    messagingSenderId: '610335358292',
    projectId: 'iot-project-af3d8',
    authDomain: 'iot-project-af3d8.firebaseapp.com',
    databaseURL: 'https://iot-project-af3d8-default-rtdb.firebaseio.com',
    storageBucket: 'iot-project-af3d8.appspot.com',
    measurementId: 'G-WRWVQL82TN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZRMOLn5zur9ijJpfxXaZrj2eq18t5Z0E',
    appId: '1:610335358292:android:2b8fd536e0748b52485cc1',
    messagingSenderId: '610335358292',
    projectId: 'iot-project-af3d8',
    databaseURL: 'https://iot-project-af3d8-default-rtdb.firebaseio.com',
    storageBucket: 'iot-project-af3d8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzzzzedxaL4WCh_cY2TUOniFdCQDCabBU',
    appId: '1:610335358292:ios:7b2e2108b391cd4f485cc1',
    messagingSenderId: '610335358292',
    projectId: 'iot-project-af3d8',
    databaseURL: 'https://iot-project-af3d8-default-rtdb.firebaseio.com',
    storageBucket: 'iot-project-af3d8.appspot.com',
    androidClientId: '610335358292-g6c42jpdlhdsojrsiquq6vejf2s9pmrq.apps.googleusercontent.com',
    iosClientId: '610335358292-4r04r4pbu22664nji4unvdvdl76pj37r.apps.googleusercontent.com',
    iosBundleId: 'com.example.modernlogintute',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzzzzedxaL4WCh_cY2TUOniFdCQDCabBU',
    appId: '1:610335358292:ios:7b2e2108b391cd4f485cc1',
    messagingSenderId: '610335358292',
    projectId: 'iot-project-af3d8',
    databaseURL: 'https://iot-project-af3d8-default-rtdb.firebaseio.com',
    storageBucket: 'iot-project-af3d8.appspot.com',
    androidClientId: '610335358292-g6c42jpdlhdsojrsiquq6vejf2s9pmrq.apps.googleusercontent.com',
    iosClientId: '610335358292-4r04r4pbu22664nji4unvdvdl76pj37r.apps.googleusercontent.com',
    iosBundleId: 'com.example.modernlogintute',
  );
}
