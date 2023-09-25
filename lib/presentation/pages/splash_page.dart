import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presence_bloc_firebase/routes/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        context.goNamed(Routes.login);
      } else {
        context.goNamed(Routes.navbar);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: 100,
            //   height: 100,
            //   margin: const EdgeInsets.only(bottom: 50),
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/logo_airplane.png'),
            //     ),
            //   ),
            // ),
            Text(
              'PRESENCE APP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                letterSpacing: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
