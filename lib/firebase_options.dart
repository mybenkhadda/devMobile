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
    apiKey: 'AIzaSyAl3xQlTgtQq4aMXvk5yoStgjJIPnXaxDg',
    appId: '1:172646054817:web:acc4b99b388bbae31429e0',
    messagingSenderId: '172646054817',
    projectId: 'matjar-c6a1e',
    authDomain: 'matjar-c6a1e.firebaseapp.com',
    databaseURL: 'https://matjar-c6a1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'matjar-c6a1e.appspot.com',
    measurementId: 'G-LX84GKF8K6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD16__WGR9SLaXWcgV1Q4YhvumLaOOjuZ0',
    appId: '1:172646054817:android:1c2445919eccc5851429e0',
    messagingSenderId: '172646054817',
    projectId: 'matjar-c6a1e',
    databaseURL: 'https://matjar-c6a1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'matjar-c6a1e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAV-iNNTmWo_WQ4MWafV2_4NrCqEHWkOmM',
    appId: '1:172646054817:ios:c0a788f7dfce28b51429e0',
    messagingSenderId: '172646054817',
    projectId: 'matjar-c6a1e',
    databaseURL: 'https://matjar-c6a1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'matjar-c6a1e.appspot.com',
    iosBundleId: 'com.example.projectflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAV-iNNTmWo_WQ4MWafV2_4NrCqEHWkOmM',
    appId: '1:172646054817:ios:050da0b6801991a21429e0',
    messagingSenderId: '172646054817',
    projectId: 'matjar-c6a1e',
    databaseURL: 'https://matjar-c6a1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'matjar-c6a1e.appspot.com',
    iosBundleId: 'com.example.projectflutter.RunnerTests',
  );
}