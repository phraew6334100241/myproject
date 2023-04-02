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
    apiKey: 'AIzaSyDBz3aNJvsIDvzZBlTWbaFVJqNilSpPvoo',
    appId: '1:1057899962140:web:681ef7bbe3aaf09188a4d9',
    messagingSenderId: '1057899962140',
    projectId: 'flutter-firebase-app-dc501',
    authDomain: 'flutter-firebase-app-dc501.firebaseapp.com',
    storageBucket: 'flutter-firebase-app-dc501.appspot.com',
    measurementId: 'G-JNCF3EYXHR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMv8SLlk0IZ5G9rspyBzbw8LVzPZKsh5g',
    appId: '1:1057899962140:android:b77bb4edac97650c88a4d9',
    messagingSenderId: '1057899962140',
    projectId: 'flutter-firebase-app-dc501',
    storageBucket: 'flutter-firebase-app-dc501.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSrk1l6WZteP1u6e0tdx_bBIXjuLUibaM',
    appId: '1:1057899962140:ios:fb57e18e3e8777b588a4d9',
    messagingSenderId: '1057899962140',
    projectId: 'flutter-firebase-app-dc501',
    storageBucket: 'flutter-firebase-app-dc501.appspot.com',
    iosClientId: '1057899962140-iugijo96f87ri0l19r9tbqoomnqpl2j3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSrk1l6WZteP1u6e0tdx_bBIXjuLUibaM',
    appId: '1:1057899962140:ios:fb57e18e3e8777b588a4d9',
    messagingSenderId: '1057899962140',
    projectId: 'flutter-firebase-app-dc501',
    storageBucket: 'flutter-firebase-app-dc501.appspot.com',
    iosClientId: '1057899962140-iugijo96f87ri0l19r9tbqoomnqpl2j3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseAuth',
  );
}