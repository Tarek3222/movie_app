import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});

 final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
            alignment: Alignment.centerLeft,
            child:  Text(text, style:const TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),));
  }
}