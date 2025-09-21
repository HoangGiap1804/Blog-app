import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/features/blog/presentation/pages/create_blog_page.dart';
import 'package:share_blog/features/blog/presentation/pages/get_list_blog_page.dart';
import 'package:share_blog/features/user/presentation/pages/user_profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController _pageController;

  late List<Widget> pages;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.add, size: 30),
    Icon(Icons.favorite, size: 30),
    Icon(Icons.person, size: 30),
    Icon(Icons.settings, size: 30),
  ];

  @override
  void initState() {
    super.initState();
    pages = const [
      GetListBlogPage(),
      CreateBlogPage(),
      Center(child: Text("Home Page", style: TextStyle(fontSize: 25))),
      UserProfilePage(),
      Center(child: Text("Search Page", style: TextStyle(fontSize: 25))),
    ];
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            children: pages,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index; // đồng bộ khi vuốt
              });
            },
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          backgroundColor: AppPallete.transparentColor,
          color: AppPallete.gradient3,
          items: items,
          height: 60,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
