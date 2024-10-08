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
    apiKey: 'AIzaSyDBDnm2iPQj-XCDqXSToaiDivS5YpYjsI4',
    appId: '1:102553109848:web:4fbb86dddf1f6bb353112d',
    messagingSenderId: '102553109848',
    projectId: 'chat-app-b1070',
    authDomain: 'chat-app-b1070.firebaseapp.com',
    storageBucket: 'chat-app-b1070.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7G93qEOrZF4DJAPYN_BLzYJEyaI3gArw',
    appId: '1:102553109848:android:4cc5f2b3585f118053112d',
    messagingSenderId: '102553109848',
    projectId: 'chat-app-b1070',
    storageBucket: 'chat-app-b1070.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwTbBoTLlpMsmGJJT-mtQG6GrXvn1WXQM',
    appId: '1:102553109848:ios:387f12bc547c2b6d53112d',
    messagingSenderId: '102553109848',
    projectId: 'chat-app-b1070',
    storageBucket: 'chat-app-b1070.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwTbBoTLlpMsmGJJT-mtQG6GrXvn1WXQM',
    appId: '1:102553109848:ios:387f12bc547c2b6d53112d',
    messagingSenderId: '102553109848',
    projectId: 'chat-app-b1070',
    storageBucket: 'chat-app-b1070.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDBDnm2iPQj-XCDqXSToaiDivS5YpYjsI4',
    appId: '1:102553109848:web:6fffd1691821baa653112d',
    messagingSenderId: '102553109848',
    projectId: 'chat-app-b1070',
    authDomain: 'chat-app-b1070.firebaseapp.com',
    storageBucket: 'chat-app-b1070.appspot.com',
  );
}
