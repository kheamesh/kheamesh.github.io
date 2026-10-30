// File generated or configured for Firebase options.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'you can reconfigure this by running the FlutterFire CLI.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDWweB6zMW472TiqsaMU-wnJBwJPwYn0BA',
    appId: '1:472598060862:web:cf4c44beb3151b0a5e166f',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    authDomain: 'resume-a3e92.firebaseapp.com',
    databaseURL: 'https://resume-a3e92-default-rtdb.firebaseio.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
    measurementId: 'G-VQZRTCYWCJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOZuqU6wDh29g5pHLWjQQ6wnq1W9h6iGs',
    appId: '1:472598060862:android:4c256303626187415e166f',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    databaseURL: 'https://resume-a3e92-default-rtdb.firebaseio.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz2NxA9bu9pOhDXsLUzNk13vgWG8PoAKI',
    appId: '1:472598060862:ios:409e6f6ca88492d45e166f',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    databaseURL: 'https://resume-a3e92-default-rtdb.firebaseio.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
    iosBundleId: 'com.example.resume',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAz2NxA9bu9pOhDXsLUzNk13vgWG8PoAKI',
    appId: '1:472598060862:ios:409e6f6ca88492d45e166f',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    databaseURL: 'https://resume-a3e92-default-rtdb.firebaseio.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
    iosBundleId: 'com.example.resume',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWweB6zMW472TiqsaMU-wnJBwJPwYn0BA',
    appId: '1:472598060862:web:042624c64cfac6b15e166f',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    authDomain: 'resume-a3e92.firebaseapp.com',
    databaseURL: 'https://resume-a3e92-default-rtdb.firebaseio.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
    measurementId: 'G-KZE1QYNLF8',
  );
}
