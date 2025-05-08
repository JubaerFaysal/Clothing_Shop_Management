import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_shop/Authetication/login.dart';
import 'package:tailor_shop/page/home.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //useer is logged in
            if (snapshot.hasData) {
              return const HomePage();
            }
            //user is not logged in
            else {
              return const Login();
            }
          }),
    );
  }
}
