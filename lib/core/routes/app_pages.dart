import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:share_blog/features/auth/presentation/pages/login_page.dart';
import 'package:share_blog/features/auth/presentation/pages/signup_page.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:share_blog/features/blog/presentation/pages/home_page.dart';

class AppPages {
  static const inital = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 2000),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.signup,
      page: () => SignupPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 2000),
    ),
    GetPage(
      name: Routes.blog,
      page: () => BlogPage(blog: Get.arguments as BlogEntity),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 2000),
    ),
  ];
}

class Routes {
  static const home = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const blog = '/blog';
}
