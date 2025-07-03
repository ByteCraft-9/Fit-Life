import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBKInbz3hyji9L1iVdB-kUtK8qCQ2Aoeok",
            authDomain: "fit-life-in957q.firebaseapp.com",
            projectId: "fit-life-in957q",
            storageBucket: "fit-life-in957q.appspot.com",
            messagingSenderId: "314492583316",
            appId: "1:314492583316:web:65a9e8e9b28883ba26a381"));
  } else {
    await Firebase.initializeApp();
  }
}
