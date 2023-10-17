import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/components/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget 
{
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 
  void signIn() async {
  // Get The Auth Service
  final authService = Provider.of<AuthService>(context, listen: false);
  try
  {
     await authService.signInWithEmailandPassword(
      emailController.text, 
      passwordController.text,);
  }
  catch(e)
  {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);
  }
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 237, 255),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            
            // Logo
            Icon(
              Icons.message,
              size: 90,
              color: Colors.blueGrey,
              ),

            const SizedBox(height: 20),
            // Welcome Back Text Message
              const Text(
                "Welcome Back! You've Been Missed!",
                 style: TextStyle(
                  fontSize: 20,
                 ),
              ),
              const SizedBox(height: 12),
            // Email Text Field
            MyTextField(
              controller: emailController, 
              hintText: 'Email', 
              obscureText: false),

          const SizedBox(height: 10),
            
            // Password Text Field
              MyTextField(
              controller: passwordController, 
              hintText: 'Password', 
              obscureText: true),
          
            
          const SizedBox(height: 12),

            // Sign In Button
          MyButton(onTap: signIn, text: "Sign In"),
          
          const SizedBox(height: 20),

            // Not a member? Register Now!
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            Text('Not a member?'),
            
            const SizedBox(width: 6),
           
            GestureDetector(
              onTap: widget.onTap,
            child: Text(
              'Register Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
                ),
            ),
              ),
          ],
          ) 
          ],
          ),
          ),
          ),
      )
    );
  }
}