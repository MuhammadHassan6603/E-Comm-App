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
    apiKey: 'AIzaSyBKdcnAeaBTbbDm5jx-lnHYJL7VokXU468',
    appId: '1:1036014210330:web:4542f86686f4be624570a3',
    messagingSenderId: '1036014210330',
    projectId: 'ecomm-ff529',
    authDomain: 'ecomm-ff529.firebaseapp.com',
    storageBucket: 'ecomm-ff529.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAafWIziFx5vqXzc6hRb137lKCCHwOpJs0',
    appId: '1:1036014210330:android:2a8fd060448163c34570a3',
    messagingSenderId: '1036014210330',
    projectId: 'ecomm-ff529',
    storageBucket: 'ecomm-ff529.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkRzqHyTxsBNGFJ78HxT9oPAd3SiHtKD4',
    appId: '1:1036014210330:ios:fdcd88cb0dbdffca4570a3',
    messagingSenderId: '1036014210330',
    projectId: 'ecomm-ff529',
    storageBucket: 'ecomm-ff529.appspot.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkRzqHyTxsBNGFJ78HxT9oPAd3SiHtKD4',
    appId: '1:1036014210330:ios:fdcd88cb0dbdffca4570a3',
    messagingSenderId: '1036014210330',
    projectId: 'ecomm-ff529',
    storageBucket: 'ecomm-ff529.appspot.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBKdcnAeaBTbbDm5jx-lnHYJL7VokXU468',
    appId: '1:1036014210330:web:0814fea1705f3f2f4570a3',
    messagingSenderId: '1036014210330',
    projectId: 'ecomm-ff529',
    authDomain: 'ecomm-ff529.firebaseapp.com',
    storageBucket: 'ecomm-ff529.appspot.com',
  );
}
