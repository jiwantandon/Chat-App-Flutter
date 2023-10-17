import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/components/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget 
{
  final String recieverUserEmail;
  final String recieverUserID;
  const ChatPage({
    super.key, 
    required this.recieverUserEmail, 
    required this.recieverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> 
{
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendMessage() async
  {
    //Only Send Msg if there is somethign to send
    if(_messageController.text.isNotEmpty)
    {
        await _chatService.sendMessage(
          widget.recieverUserID, 
          _messageController.text);

          // Clear The Text Controller After Sending The Msg
          _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recieverUserEmail)),
      body: Column(
        children: [
          // Messages
          Expanded(child: _buildMessageList(),
          ),
          // User Input
          _buildMessageInput(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
  

  // Build Message List
  Widget _buildMessageList()
  {
    return StreamBuilder(stream: _chatService.getMessages(widget.recieverUserID, _firebaseAuth.currentUser!.uid),
    builder: (context, snapshot)
    {
      if(snapshot.hasError)
      {
        return Text('Error${snapshot.error}');
      }
      if(snapshot.connectionState == ConnectionState.waiting)
      {
        return const Text('Loading...');
      }
      return ListView(
        children: snapshot.data!.docs
        .map((document) => _buildMessageItem(document))
        .toList(),
      );
    },
    );
  }

  // Build Message Item
  Widget _buildMessageItem(DocumentSnapshot document)
  {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Align the msgs to the right if the current use, otherwise to the left
        var alignment =  (data['senderId'] == _firebaseAuth.currentUser!.uid) 
        ? Alignment.centerRight
        : Alignment.centerLeft;

        return Container(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: 
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
              mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 4,),
              ChatBubble(message: data['message']),
            ],
            ),
            ),
        );
  }

  // Build Message Input
  Widget _buildMessageInput()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        children: [
          // Text Field
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Enter Your Message',
              obscureText: false,
              ),
          ),
          // Send Button
          IconButton(
            onPressed: sendMessage, 
            icon: const Icon(
              Icons.arrow_upward, 
              size: 40,),
              )
    
        ],
        ),
    );
  }
}