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
    apiKey: 'AIzaSyAWI9EgW86PHQziKVq9hKgfEzgphiTyYSw',
    appId: '1:692168241918:web:496af473209988c91f6baf',
    messagingSenderId: '692168241918',
    projectId: 'trusin-421f7',
    authDomain: 'trusin-421f7.firebaseapp.com',
    storageBucket: 'trusin-421f7.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-BpV1mG9QlTGaDSUpkq8YIyyZEqAZaQk',
    appId: '1:692168241918:android:9499748711cb01f21f6baf',
    messagingSenderId: '692168241918',
    projectId: 'trusin-421f7',
    storageBucket: 'trusin-421f7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJnjDQ9XIuQa_NNjUPyhsE76313Z7_Ojg',
    appId: '1:692168241918:ios:7b18b8afa9077ce71f6baf',
    messagingSenderId: '692168241918',
    projectId: 'trusin-421f7',
    storageBucket: 'trusin-421f7.firebasestorage.app',
    iosBundleId: 'com.example.trusinApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJnjDQ9XIuQa_NNjUPyhsE76313Z7_Ojg',
    appId: '1:692168241918:ios:7b18b8afa9077ce71f6baf',
    messagingSenderId: '692168241918',
    projectId: 'trusin-421f7',
    storageBucket: 'trusin-421f7.firebasestorage.app',
    iosBundleId: 'com.example.trusinApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWI9EgW86PHQziKVq9hKgfEzgphiTyYSw',
    appId: '1:692168241918:web:22f039edb2eba3111f6baf',
    messagingSenderId: '692168241918',
    projectId: 'trusin-421f7',
    authDomain: 'trusin-421f7.firebaseapp.com',
    storageBucket: 'trusin-421f7.firebasestorage.app',
  );
}
