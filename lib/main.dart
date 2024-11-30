import 'package:app_packtrack/auth/login.dart';
import 'package:app_packtrack/auth/signup.dart';
import 'package:app_packtrack/homepage.dart';
import 'package:app_packtrack/store/list_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCfBkBfgmrSQtv8lHwZKnQWpcr1zQ_BtPk",
    authDomain: "app-packtrack-c8d8e.firebaseapp.com",
    databaseURL: "https://app-packtrack-c8d8e-default-rtdb.firebaseio.com",
    projectId: "app-packtrack-c8d8e",
    storageBucket: "app-packtrack-c8d8e.firebasestorage.app",
    messagingSenderId: "739492298588",
    appId: "1:739492298588:web:8f3e06c4f4edad2e074b99",
    measurementId: "G-S5YDDWBHGD",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
