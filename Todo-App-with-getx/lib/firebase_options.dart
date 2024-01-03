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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCjr1fRAa2B9ILzCOBim0i14LSEFu9uE2g',
    appId: '1:862910704179:web:6ff03c10c1d2e7495dd146',
    messagingSenderId: '862910704179',
    projectId: 'todo-app-with-getx-548d5',
    authDomain: 'todo-app-with-getx-548d5.firebaseapp.com',
    storageBucket: 'todo-app-with-getx-548d5.appspot.com',
    measurementId: 'G-H4Q77KTK90',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtbGsfVyEjD09-O-3YJmqwr9kPzbYrvC8',
    appId: '1:862910704179:android:7dd3f2e960b3c1375dd146',
    messagingSenderId: '862910704179',
    projectId: 'todo-app-with-getx-548d5',
    storageBucket: 'todo-app-with-getx-548d5.appspot.com',
  );
}