// lib/main.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_app/auth/login.dart';
import 'package:store_app/auth/signup.dart';
import 'package:store_app/pages/experiment.dart';
import 'package:store_app/screens/home_page.dart';
import 'package:store_app/screens/splash_screen.dart';
import 'package:store_app/screens/update_product_page.dart';

// لا تحتاج لاستيراد CategoryProductsPage هنا

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAoGcREMMYU0j7ZGY9eJT38a8lZkAZDC70',
          appId: '1:849992411206:android:40e7eeaf7f004d72b38247',
          messagingSenderId: '849992411206',
          projectId: 'storeeeeeeeeee-1fb10'));

  runApp(StoreApp());
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _MyAppState();
}

class _MyAppState extends State<StoreApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===================== User is currently signed out!');
      } else {
        print('===================== User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : SplashScreen(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "homepage": (context) => HomePage(),
        UpdateProductPage.id: (context) => UpdateProductPage(),
        "experiment": (context) => Experiment(),
      },
      /*
      routes: {
        HomePage.id: (context) => HomePage(),
        UpdateProductPage.id: (context) => UpdateProductPage(),
        // إزالة CategoryProductsPage.id من هنا
      },
      initialRoute: HomePage.id,*/
    );
  }
}
