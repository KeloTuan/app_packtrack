import 'package:app_packtrack/auth/auth_provider.dart';
import 'package:app_packtrack/auth/login.dart';
import 'package:app_packtrack/auth/signup.dart';
import 'package:app_packtrack/homepage.dart';
import 'package:app_packtrack/store/list_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authState.when(
        data: (user) => user != null ? StoreListScreen() : LoginScreen(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
