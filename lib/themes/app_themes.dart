import 'package:flutter/material.dart';

/// 应用主题定义
class AppThemes {
  // 预设主题
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'NotoSansSC',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF212121),
    fontFamily: 'NotoSansSC',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF303030),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );

  static final ThemeData blueTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFE3F2FD),
    fontFamily: 'NotoSansSC',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );

  static final ThemeData pinkTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: const Color(0xFFFCE4EC),
    fontFamily: 'NotoSansSC',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.pink,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );

  // 键盘主题
  static KeyboardTheme lightKeyboardTheme = KeyboardTheme(
    backgroundColor: const Color(0xFFF5F5F5),
    keyBackgroundColor: Colors.white,
    keyTextColor: Colors.black87,
    candidateBarBackgroundColor: Colors.white,
    candidateTextColor: Colors.black87,
    aiReplyBarBackgroundColor: Colors.white,
    aiReplyBackgroundColor: const Color(0xFFE3F2FD),
    aiReplyTextColor: Colors.blue,
    borderColor: Colors.grey.shade300,
  );

  static KeyboardTheme darkKeyboardTheme = KeyboardTheme(
    backgroundColor: const Color(0xFF303030),
    keyBackgroundColor: const Color(0xFF424242),
    keyTextColor: Colors.white,
    candidateBarBackgroundColor: const Color(0xFF424242),
    candidateTextColor: Colors.white,
    aiReplyBarBackgroundColor: const Color(0xFF424242),
    aiReplyBackgroundColor: Colors.blue.withOpacity(0.3),
    aiReplyTextColor: Colors.white,
    borderColor: Colors.grey.shade700,
  );

  static KeyboardTheme blueKeyboardTheme = KeyboardTheme(
    backgroundColor: const Color(0xFFE3F2FD),
    keyBackgroundColor: Colors.white,
    keyTextColor: Colors.black87,
    candidateBarBackgroundColor: Colors.white,
    candidateTextColor: Colors.black87,
    aiReplyBarBackgroundColor: Colors.white,
    aiReplyBackgroundColor: Colors.blue.withOpacity(0.1),
    aiReplyTextColor: Colors.blue,
    borderColor: Colors.blue.shade100,
  );

  static KeyboardTheme pinkKeyboardTheme = KeyboardTheme(
    backgroundColor: const Color(0xFFFCE4EC),
    keyBackgroundColor: Colors.white,
    keyTextColor: Colors.black87,
    candidateBarBackgroundColor: Colors.white,
    candidateTextColor: Colors.black87,
    aiReplyBarBackgroundColor: Colors.white,
    aiReplyBackgroundColor: Colors.pink.withOpacity(0.1),
    aiReplyTextColor: Colors.pink,
    borderColor: Colors.pink.shade100,
  );
}

/// 键盘主题定义
class KeyboardTheme {
  final Color backgroundColor;
  final Color keyBackgroundColor;
  final Color keyTextColor;
  final Color candidateBarBackgroundColor;
  final Color candidateTextColor;
  final Color aiReplyBarBackgroundColor;
  final Color aiReplyBackgroundColor;
  final Color aiReplyTextColor;
  final Color borderColor;

  KeyboardTheme({
    required this.backgroundColor,
    required this.keyBackgroundColor,
    required this.keyTextColor,
    required this.candidateBarBackgroundColor,
    required this.candidateTextColor,
    required this.aiReplyBarBackgroundColor,
    required this.aiReplyBackgroundColor,
    required this.aiReplyTextColor,
    required this.borderColor,
  });
}