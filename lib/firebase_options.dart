
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
    apiKey: 'AIzaSyAX9iBigv7h-sbTc6YKxm8ArRcq3D33naE',
    appId: '1:961540439243:web:642d3767eacfca8d35af4e',
    messagingSenderId: '961540439243',
    projectId: 'ezdental-acd94',
    authDomain: 'ezdental-acd94.firebaseapp.com',
    storageBucket: 'ezdental-acd94.appspot.com',
    measurementId: 'G-P3ZXEHYLN3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZyW6pEO8AhL-YhT-1m4H9UiQQK_dhFUc',
    appId: '1:961540439243:android:36bd6a6b120cff0d35af4e',
    messagingSenderId: '961540439243',
    projectId: 'ezdental-acd94',
    storageBucket: 'ezdental-acd94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhSC88g5JhA0mYaQZA-lvJW2PL4Qpojnc',
    appId: '1:961540439243:ios:57c3cfdb91f9fc5135af4e',
    messagingSenderId: '961540439243',
    projectId: 'ezdental-acd94',
    storageBucket: 'ezdental-acd94.appspot.com',
    iosBundleId: 'com.example.ezdental',
  );
}
