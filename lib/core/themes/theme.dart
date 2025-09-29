import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_blog/core/themes/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      scrolledUnderElevation: 0,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}

class MarkdownThemes {
  // Light theme
  static final lightTheme = MarkdownStyleSheet(
    h1: TextStyle(
      color: Colors.blue,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    h2: TextStyle(
      color: Colors.indigo,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    h3: TextStyle(
      color: Colors.deepPurple,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    h4: TextStyle(
      color: Colors.purple,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    h5: TextStyle(
      color: Colors.pink,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    h6: TextStyle(
      color: Colors.orange,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),

    p: TextStyle(color: Colors.black87, fontSize: 16),
    strong: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    em: TextStyle(color: Colors.orange, fontStyle: FontStyle.italic),
    blockquote: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
    code: TextStyle(
      color: Colors.teal,
      fontFamily: 'monospace',
      backgroundColor: Colors.grey[200],
    ),
    a: TextStyle(
      color: Colors.blueAccent,
      decoration: TextDecoration.underline,
    ),

    listBullet: TextStyle(color: Colors.green, fontSize: 16),
    horizontalRuleDecoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(2),
    ),

    tableHead: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    tableBody: TextStyle(color: Colors.black87),

    blockSpacing: 8.0,
    listIndent: 24.0,
    codeblockPadding: EdgeInsets.all(8),
    codeblockDecoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // Dark theme
  static final darkTheme = MarkdownStyleSheet(
    h1: TextStyle(
      color: Colors.lightBlue[300],
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    h2: TextStyle(
      color: Colors.indigo[200],
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    h3: TextStyle(
      color: Colors.deepPurple[200],
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    h4: TextStyle(
      color: Colors.purple[200],
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    h5: TextStyle(
      color: Colors.pink[200],
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    h6: TextStyle(
      color: Colors.orange[200],
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),

    p: TextStyle(color: Colors.white70, fontSize: 16),
    strong: TextStyle(color: Colors.red[300], fontWeight: FontWeight.bold),
    em: TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
    blockquote: TextStyle(color: Colors.grey[400], fontStyle: FontStyle.italic),
    code: TextStyle(
      color: Colors.teal[200],
      fontFamily: 'monospace',
      backgroundColor: Colors.grey[800],
    ),
    a: TextStyle(color: Colors.blue[200], decoration: TextDecoration.underline),

    listBullet: TextStyle(color: Colors.green[300], fontSize: 16),
    horizontalRuleDecoration: BoxDecoration(
      color: Colors.grey[600],
      borderRadius: BorderRadius.circular(2),
    ),

    tableHead: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    tableBody: TextStyle(color: Colors.white70),

    blockSpacing: 8.0,
    listIndent: 24.0,
    codeblockPadding: EdgeInsets.all(8),
    codeblockDecoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
