import 'package:flutter/material.dart';

class MyButton extends StatelessWidget 
{
  final void Function()? onTap;
  final String text;
  const MyButton({
    super.key, 
    required this.onTap,
    required this.text,
    });

  @override
  Widget build(BuildContext context) 
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Center(
          child: Text(
            text,
            style:  const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              ),
              ),
              ),
          ),
      );
  }
}
