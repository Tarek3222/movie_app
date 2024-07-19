import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.hintText,  this.onChanged, this.validator, this.obscureText = false, required this.suffixIcon, required this.labelText});
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            obscureText: obscureText!,
            validator: validator,
            onChanged: onChanged ,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              labelText:labelText ,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              fillColor: Colors.black,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
              ),
            ),
          );
  }
}