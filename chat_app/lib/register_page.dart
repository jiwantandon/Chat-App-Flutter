import 'package:chat_app/components/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/my_button.dart';
import 'components/my_text_field.dart';

class RegisterPage extends StatefulWidget 
{
    final void Function()? onTap;
    const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> 
{
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //Sign Up User

  void signUp() async 
  {
     if(passwordController.text != confirmPasswordController.text)
     {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match!"),
            ),
            );
            return;
     }
     //Get Auth Service
     final authService = Provider.of<AuthService>(context, listen: false);
     try
     {
        await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);
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
            // Create Account Text Message
              const Text(
                "Let's Create an Account For You!",
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
          const SizedBox(height: 10),
            
            // Password Text Field
              MyTextField(
              controller: confirmPasswordController, 
              hintText: 'Confirm Password', 
              obscureText: true),
          
            
          const SizedBox(height: 12),

            // Sign Up Button
          MyButton(onTap: signUp, text: "Sign Up"),
          
          const SizedBox(height: 20),

            // Not a member? Register Now!
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            const Text('Already a member?'),
            const SizedBox(width: 6),
            
            GestureDetector(
              onTap: widget.onTap,
              child: const Text(
                'Log In Now',
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