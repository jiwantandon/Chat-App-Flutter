import 'package:chat_app/components/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  // Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Out User
void signOut()
{
  // Get Auth Services
  final authService = Provider.of<AuthService>(context, listen: false);
  authService.signOut(); 
}

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),
      actions: [
          // Sign Out Button
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))

      ],
      ),
    body: _buildUserList(),
    );
  }
  // Build a list of Users except for the current logged in user
  Widget _buildUserList()
  {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError)
        {
           return const Text('Error'); 
        }
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
          .map<Widget>((doc) => _buildUserListItem(doc)).
          toList(),
        );
      },
      );
  }
   // Build Individual Usser List Item
   Widget _buildUserListItem(DocumentSnapshot document)
  {
    Map<String, dynamic> data =  document.data()! as Map<String, dynamic>;
    // Display All Users Except Current User
    if(_auth.currentUser!.email != data['email'])
    {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          // Pass the clicked User's ID to the Chat Page
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatPage(
            recieverUserEmail: data['email'],
            recieverUserID: data['uid'],
          ),),);
        }
      );
    }
    else
    {
      // Return Empty Container
      return Container();
    }
  }
} 