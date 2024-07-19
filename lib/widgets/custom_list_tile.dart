import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {

    return ListTile(
              title:  Text(title),
              leading:  Icon(icon, color: Colors.red,),
              onTap: onTap,
            );
  }
}