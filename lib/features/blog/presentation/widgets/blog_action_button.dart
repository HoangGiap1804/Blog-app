import 'package:flutter/material.dart';
import 'package:share_blog/core/themes/app_pallete.dart';

class BlogActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const BlogActionButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppPallete.gradient1, AppPallete.gradient2],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {},
        child: Row(
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
        ),
      ),
    );
  }
}
