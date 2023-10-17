import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../model/message.dart';

class ChatService extends ChangeNotifier
{
  // Get Instance of Auth and Firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Send Msg
  Future<void> sendMessage(String recieverId, String message) async
  {
      // Get Current User Info
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
      final Timestamp timestamp = Timestamp.now();
      
      // Create a New Msg
      Message newMessage = Message(
        senderId: currentUserId, 
        senderEmail: currentUserEmail, 
        recieverId: recieverId, 
        timestamp: timestamp, 
        message: message
        );

      // Construct Chat Room ID from Current User ID and reciever ID (sorted to ensure uniqueness)
      List<String> ids = [currentUserId, recieverId];
      ids.sort(); // Sort the Ids (This ensures that room id is always the same for any two individuals)
      String chatRoomId = ids.join("_"); // Combine the IDs to a sningle string to use as Chatroom Id
     
     // Add new Msg to Database
     await _fireStore
     .collection('chat_rooms')
     .doc(chatRoomId)
     .collection('messages')
     .add(newMessage.toMap());
     

  }
  // Get Msg
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId)
  {
    // Construct Chat Room Id from user IDs (Sorted to ensure that it matches the ID used when sendins msgs)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .orderBy('timestamp', descending: false)
    .snapshots(); 
  }
}