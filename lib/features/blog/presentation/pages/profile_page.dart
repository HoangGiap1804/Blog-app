import 'package:flutter/material.dart';
import 'package:share_blog/core/themes/app_pallete.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.blue,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(height: 150, color: Colors.deepOrange),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: AppPallete.gradient3,
                    child: Text("G", style: TextStyle(fontSize: 60)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Giap"),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Nhập văn bản...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
