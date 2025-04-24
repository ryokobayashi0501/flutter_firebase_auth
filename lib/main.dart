import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_user_auth/screen/forget_password.dart';
import 'package:flutter_simple_user_auth/screen/home.dart';
import 'package:flutter_simple_user_auth/screen/login.dart';
import 'package:flutter_simple_user_auth/screen/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyD47UB7rDu3cFoC0GPx-fwsOiYiWEnh0gE",
      authDomain: "practiceauth-4fc12.firebaseapp.com",
      projectId: "practiceauth-4fc12",
      storageBucket: "practiceauth-4fc12.firebasestorage.app",
      messagingSenderId: "979223392484",
      appId: "1:979223392484:web:0fb7c8022deda6af8e3cf1",
      measurementId: "G-Z7MF0NV1WT"
    ));
  }else{
    await Firebase.initializeApp();
  }

  if(kIsWeb){
    runApp(
      // Enable DevicePreview in Debug Builds Only
      DevicePreview(
        enabled: !kReleaseMode, // Disabled in release builds
        builder: (context) => MyApp(),
      ),
    );
  }else{
    runApp(MyApp());
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => Home(),
        '/forgot_password': (context) => forget_password(),
      },
    );
  }
}

