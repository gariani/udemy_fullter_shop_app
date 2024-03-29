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
    apiKey: 'AIzaSyBrcAaO0Pcn1m38lT6_WBjFzNJeygn7Y1M',
    appId: '1:867151229756:web:27b34b9fd48117d3a16439',
    messagingSenderId: '867151229756',
    projectId: 'shop-app-87225',
    authDomain: 'shop-app-87225.firebaseapp.com',
    databaseURL: 'https://shop-app-87225-default-rtdb.firebaseio.com',
    storageBucket: 'shop-app-87225.appspot.com',
    measurementId: 'G-Q8H11Q3ZQQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWgxQe5aF_BwA-zBitq12LE3aLOwiq45Y',
    appId: '1:867151229756:android:0e90ce12baa4be2aa16439',
    messagingSenderId: '867151229756',
    projectId: 'shop-app-87225',
    databaseURL: 'https://shop-app-87225-default-rtdb.firebaseio.com',
    storageBucket: 'shop-app-87225.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEDCL5PRiKFDg5QNdkYDSKxmUigEg3qUU',
    appId: '1:867151229756:ios:c97bb2f5635ea890a16439',
    messagingSenderId: '867151229756',
    projectId: 'shop-app-87225',
    databaseURL: 'https://shop-app-87225-default-rtdb.firebaseio.com',
    storageBucket: 'shop-app-87225.appspot.com',
    androidClientId: '867151229756-snj2krmhf6t9vv4reannuav5v4i6i468.apps.googleusercontent.com',
    iosClientId: '867151229756-3a733q0grkqmqrch51qmerjt2krjumsf.apps.googleusercontent.com',
    iosBundleId: 'com.example.shopApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEDCL5PRiKFDg5QNdkYDSKxmUigEg3qUU',
    appId: '1:867151229756:ios:c97bb2f5635ea890a16439',
    messagingSenderId: '867151229756',
    projectId: 'shop-app-87225',
    databaseURL: 'https://shop-app-87225-default-rtdb.firebaseio.com',
    storageBucket: 'shop-app-87225.appspot.com',
    androidClientId: '867151229756-snj2krmhf6t9vv4reannuav5v4i6i468.apps.googleusercontent.com',
    iosClientId: '867151229756-3a733q0grkqmqrch51qmerjt2krjumsf.apps.googleusercontent.com',
    iosBundleId: 'com.example.shopApp',
  );
}
