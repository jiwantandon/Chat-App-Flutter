import 'package:chat_app/components/services/login_or_registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
         if(snapshot.hasData)
         {
          return const HomePage();
         }
          //User is not logged in
         else
         {
           return const LoginOrRegister();
         } 
        },
        )
    );
  }
}