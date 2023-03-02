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
    apiKey: 'AIzaSyBRDckQNwpUTwyRDCx8_7pdnnjKSWjlDPc',
    appId: '1:126427350071:web:483112561a4a46fc266bb2',
    messagingSenderId: '126427350071',
    projectId: 'testassigment',
    authDomain: 'testassigment.firebaseapp.com',
    storageBucket: 'testassigment.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCI6523_7T2PsXS3jw5VXoT0GIXwd7P9u4',
    appId: '1:126427350071:android:c249473cfe857094266bb2',
    messagingSenderId: '126427350071',
    projectId: 'testassigment',
    storageBucket: 'testassigment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7JRsxJPr3aDXu7PxsmLlERvxiybAQlQA',
    appId: '1:126427350071:ios:ceb99014c51858e5266bb2',
    messagingSenderId: '126427350071',
    projectId: 'testassigment',
    storageBucket: 'testassigment.appspot.com',
    iosClientId: '126427350071-jg2oo8hug6o1evsca51livm29da9ocif.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7JRsxJPr3aDXu7PxsmLlERvxiybAQlQA',
    appId: '1:126427350071:ios:ceb99014c51858e5266bb2',
    messagingSenderId: '126427350071',
    projectId: 'testassigment',
    storageBucket: 'testassigment.appspot.com',
    iosClientId: '126427350071-jg2oo8hug6o1evsca51livm29da9ocif.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
