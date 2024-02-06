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
    apiKey: 'AIzaSyAVw9y5zjESoRP8zJZfpbkeqP7cShfAH38',
    appId: '1:34103758731:web:19fa042e53d7e67546a98e',
    messagingSenderId: '34103758731',
    projectId: 'abu-hashem-fashion-demo',
    authDomain: 'abu-hashem-fashion-demo.firebaseapp.com',
    storageBucket: 'abu-hashem-fashion-demo.appspot.com',
    measurementId: 'G-KLWWLKMME0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGnKl-5adyC0IwAHV8YJxgN8Vk28QthO4',
    appId: '1:34103758731:android:b2b622eed15a2ae446a98e',
    messagingSenderId: '34103758731',
    projectId: 'abu-hashem-fashion-demo',
    storageBucket: 'abu-hashem-fashion-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmCgSIeVeRZWtiNAbdyF7W6eUXjQNques',
    appId: '1:34103758731:ios:2d9e3e8d7043d15c46a98e',
    messagingSenderId: '34103758731',
    projectId: 'abu-hashem-fashion-demo',
    storageBucket: 'abu-hashem-fashion-demo.appspot.com',
    iosBundleId: 'com.example.abuHashemFashion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmCgSIeVeRZWtiNAbdyF7W6eUXjQNques',
    appId: '1:34103758731:ios:d6f3c071029c8fd646a98e',
    messagingSenderId: '34103758731',
    projectId: 'abu-hashem-fashion-demo',
    storageBucket: 'abu-hashem-fashion-demo.appspot.com',
    iosBundleId: 'com.example.abuHashemFashion.RunnerTests',
  );
}
