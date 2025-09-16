import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/features/blog/presentation/pages/create_blog_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isView = false;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.add, size: 30),
    Icon(Icons.favorite, size: 30),
    Icon(Icons.settings, size: 30),
    Icon(Icons.person, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(child: CreateBlogPage(isView: isView)),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppPallete.transparentColor,
          color: AppPallete.gradient3,
          items: items,
          height: 60,
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          activeIcon: Icons.close,
          backgroundColor: AppPallete.gradient3,
          foregroundColor: AppPallete.backgroundColor,
          overlayOpacity: 0.4,
          direction: SpeedDialDirection.up, // bung nút lên trên
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Thêm mới',
              onTap: () => print("Nhấn Thêm"),
            ),
            SpeedDialChild(
              child: Icon(Icons.share),
              label: 'Chia sẻ',
              onTap: () => print("Nhấn Share"),
            ),
            SpeedDialChild(
              child: Icon((isView) ? Icons.edit : Icons.remove_red_eye),
              label: (isView) ? "Edit" : 'Show view',
              onTap: () {
                setState(() {
                  isView = !isView;
                });
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
