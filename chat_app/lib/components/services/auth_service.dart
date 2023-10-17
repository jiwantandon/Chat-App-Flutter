import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthService extends ChangeNotifier 
{
  // Instance of Auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Sign User In
  Future<UserCredential> signInWithEmailandPassword(String email, String password) async
  {
    try
    {
      //Sign In
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password,);
      return userCredential;   
    } 
    // Catch Any Errors
    on FirebaseAuthException catch(e)
    {
      throw Exception(e.code);
    }
  }
  
  //Sign User Out
  Future<void> signOut() async
  {
    return await FirebaseAuth.instance.signOut();
  }
  // Create a New User
  Future<UserCredential> signUpWithEmailandPassword(String email, password) async
  {
    try
    {
      UserCredential userCredential = 
        await _firebaseAuth.createUserWithEmailAndPassword
        (email: email, 
        password: password,
        );
        // After Creating The User, Create a new doc for the user in the users collection
        _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        }, SetOptions(merge: true)
        );
        // Add a new doc in users collection if it does not alreay exists


      return userCredential;
    }
    on FirebaseAuthException catch(e)
    {
       throw Exception(e.code);
    }
        
  }

}