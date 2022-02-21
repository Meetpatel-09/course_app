import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {

  // Theme data consist of all the the theme setting throughout the application
  // settings such as colors, font size, font style, app bar, bottom navigation bar, etc.

  // Theme data for light theme.
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.lightBlue,
      canvasColor: const Color(0xffe8f4f8),
      cardColor: black,
      primaryColor: lightBlue,
      backgroundColor: white,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
          backgroundColor: lightBlue,
          elevation: 0.0,
          iconTheme: IconThemeData(color: white),
          titleTextStyle: TextStyle(
              color: white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: lightBlue,
        backgroundColor: Colors.white,
          unselectedItemColor: Colors.blueGrey
      )
  );

  // Theme data for light theme.
  static ThemeData darkTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.dark,
      canvasColor: darkCreamColor,
      cardColor: white,
      primaryColor: lightBluishColor,
      backgroundColor: black,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
          backgroundColor: lightBluishColor,
          elevation: 0.0,
          iconTheme: IconThemeData(color: white),
          titleTextStyle: TextStyle(
              color: white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: lightBluishColor,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.blueGrey
      ),
  );

  // Colors
  static Color lightBlue = Colors.lightBlue;
  static Color deepPurple = Colors.deepPurple;
  static Color blueGrey = Colors.blueGrey;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color snowWhite = Colors.black;

  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkCreamColor = Vx.gray900;
  static Color darkBluishColor = const Color(0xff403b58);
  static Color lightBluishColor = Vx.indigo500; // 667eea
}