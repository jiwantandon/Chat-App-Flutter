import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Message
{
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  
  Message({
    required this.senderId, 
    required this.senderEmail, 
    required this.recieverId, 
    required this.timestamp, 
    required this.message,
    });
    // Convert To a Map
    Map<String, dynamic> toMap()
    {
       return
       {
           'senderId': senderId,
           'senderEmail': senderEmail,
           'recieverId': recieverId,
           'message': message,
           'timestamp': timestamp,
       };
    }
}