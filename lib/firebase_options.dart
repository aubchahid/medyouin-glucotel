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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAPooL5dCZhDkqig_Oj__bO9r-Q6M8PfeA',
    appId: '1:691014317540:web:f7d0b96a5c25f0d6a143f1',
    messagingSenderId: '691014317540',
    projectId: 'medyouin-glucotel',
    authDomain: 'medyouin-glucotel.firebaseapp.com',
    storageBucket: 'medyouin-glucotel.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZo6QY_nQq5_58Yz0jyCiwsr1DwFwmpWc',
    appId: '1:691014317540:android:bba5568c4ef81112a143f1',
    messagingSenderId: '691014317540',
    projectId: 'medyouin-glucotel',
    storageBucket: 'medyouin-glucotel.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3ltnefuRn5-SQEbRXb0opijNgOcTLNkw',
    appId: '1:691014317540:ios:48fd5710d96f2eeca143f1',
    messagingSenderId: '691014317540',
    projectId: 'medyouin-glucotel',
    storageBucket: 'medyouin-glucotel.appspot.com',
    iosClientId: '691014317540-o6123qhbi7iqo491uhacjdsc1tq2sh0e.apps.googleusercontent.com',
    iosBundleId: 'com.apps.glucotel',
  );
}
