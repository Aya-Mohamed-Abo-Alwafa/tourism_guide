import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;

        final user = FirebaseAuth.instance.currentUser;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                user != null ? HomeScreen() : const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splash.jpg",
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.2),
          ),
        ],
      ),
    );
  }
}