import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup/pages/login_page.dart';
import 'package:firebase_setup/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyB52xYjx8Bcf3a8NhfnTUa7W5OE7yq32pM",
            appId: "1:968145031224:android:c03c71d4b4ef777d7dd6cd",
            messagingSenderId: "968145031224",
            projectId: "welcome-41327",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
      home: const SplashScreen(
        child: Login(),
      ),
    );
  }
}
