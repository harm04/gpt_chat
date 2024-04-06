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
    apiKey: 'AIzaSyDjPMRBMDYBDIWK7lHc8OC8VT7WFtmTs_E',
    appId: '1:651017585040:web:1cfedc83db3118fb0c7315',
    messagingSenderId: '651017585040',
    projectId: 'gpt-chat-87c0c',
    authDomain: 'gpt-chat-87c0c.firebaseapp.com',
    storageBucket: 'gpt-chat-87c0c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOX8ZSWBYxkbvWGEWi-43hGtlBDxYLU4w',
    appId: '1:651017585040:android:e1c86acec53bf4170c7315',
    messagingSenderId: '651017585040',
    projectId: 'gpt-chat-87c0c',
    storageBucket: 'gpt-chat-87c0c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkTISR282rkNC2GiZipas2Opr70iDF37E',
    appId: '1:651017585040:ios:8dfe71e0613d7bdc0c7315',
    messagingSenderId: '651017585040',
    projectId: 'gpt-chat-87c0c',
    storageBucket: 'gpt-chat-87c0c.appspot.com',
    iosBundleId: 'com.example.gptChat',
  );
}
