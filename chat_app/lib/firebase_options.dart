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
    apiKey: 'AIzaSyDd26NoJRRRObG1d1uEw6mBEs4g_0mAwls',
    appId: '1:1089324226462:web:0ba6c7ce5826665dfb688f',
    messagingSenderId: '1089324226462',
    projectId: 'chatapp-c2fa3',
    authDomain: 'chatapp-c2fa3.firebaseapp.com',
    storageBucket: 'chatapp-c2fa3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbzQTW-kL60Zth_d_wB0Cla8c-1FxOG_4',
    appId: '1:1089324226462:android:dbd1c278b94447c0fb688f',
    messagingSenderId: '1089324226462',
    projectId: 'chatapp-c2fa3',
    storageBucket: 'chatapp-c2fa3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_1ZFfed3bdtptDnob0Du9MgBEtZwDCuY',
    appId: '1:1089324226462:ios:23e1005725d2d19dfb688f',
    messagingSenderId: '1089324226462',
    projectId: 'chatapp-c2fa3',
    storageBucket: 'chatapp-c2fa3.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_1ZFfed3bdtptDnob0Du9MgBEtZwDCuY',
    appId: '1:1089324226462:ios:4224e244ccaabd4efb688f',
    messagingSenderId: '1089324226462',
    projectId: 'chatapp-c2fa3',
    storageBucket: 'chatapp-c2fa3.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}