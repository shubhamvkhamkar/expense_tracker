// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBQkS4shprgUwbtklQlMbH62-SU0Qq7jYs',
    appId: '1:636901377232:web:9089fa82b5cc001358cad5',
    messagingSenderId: '636901377232',
    projectId: 'expnses-tracker-app',
    authDomain: 'expnses-tracker-app.firebaseapp.com',
    storageBucket: 'expnses-tracker-app.firebasestorage.app',
    measurementId: 'G-FKNRL26HRR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOBIYAo83Qh6lpbSrzD40DEzeWm9_nhsY',
    appId: '1:636901377232:android:ef66c67056a5e3a458cad5',
    messagingSenderId: '636901377232',
    projectId: 'expnses-tracker-app',
    storageBucket: 'expnses-tracker-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqXgO2UnpnItLjnz4EiLaB3LeWPqE6u2g',
    appId: '1:636901377232:ios:20a51f3347f32ab058cad5',
    messagingSenderId: '636901377232',
    projectId: 'expnses-tracker-app',
    storageBucket: 'expnses-tracker-app.firebasestorage.app',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqXgO2UnpnItLjnz4EiLaB3LeWPqE6u2g',
    appId: '1:636901377232:ios:20a51f3347f32ab058cad5',
    messagingSenderId: '636901377232',
    projectId: 'expnses-tracker-app',
    storageBucket: 'expnses-tracker-app.firebasestorage.app',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQkS4shprgUwbtklQlMbH62-SU0Qq7jYs',
    appId: '1:636901377232:web:9c84986fea5331f358cad5',
    messagingSenderId: '636901377232',
    projectId: 'expnses-tracker-app',
    authDomain: 'expnses-tracker-app.firebaseapp.com',
    storageBucket: 'expnses-tracker-app.firebasestorage.app',
    measurementId: 'G-Y1PPNBWLPH',
  );
}