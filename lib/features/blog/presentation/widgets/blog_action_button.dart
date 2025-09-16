import 'package:flutter/material.dart';

class BlogActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const BlogActionButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Icon(icon, color: Colors.white),
        ),
      ],
    );
  }
}
