import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:share_blog/core/routes/app_pages.dart';
import 'package:share_blog/core/themes/theme.dart';
import 'package:share_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:share_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:share_blog/features/user/presentation/bloc/user_bloc.dart';
import 'package:share_blog/injection_container.dart';

void main() {
  runZonedGuarded(
    () {
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
      };
      initializeDependencies();
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
            BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      print("Caught by runZonedGuarded: $error");
      // Gửi log lên server nếu cần
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      initialRoute: AppPages.inital,
      getPages: AppPages.routes,
    );
  }
}
