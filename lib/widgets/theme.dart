import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      canvasColor: white,
      cardColor: Colors.black,
      backgroundColor: deepPurple,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        // unselectedItemColor: Colors.blueGrey,
        // fixedColor: context.canvasColor,
        // showUnselectedLabels: true,
      )
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.dark,
      canvasColor: black,
      cardColor: white,
      backgroundColor: Colors.deepPurple,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          backgroundColor: Colors.black,
          // unselectedItemColor: Colors.blueGrey,
          // fixedColor: context.canvasColor,
          // showUnselectedLabels: true,
          // selectedIconTheme: IconThemeData(
          //   color: Colors.deepPurple
          // )
      ),
  );

  // Colors
  // static Color creamColor = const Color(0xfff5f5f5);
  static Color darkCreamColor = Vx.gray900;
  // static Color darkBluishColor = const Color(0xff403b58);
  static Color lightBluishColor = Vx.indigo500;

  // static Color lightBlue = Colors.lightBlue;
  static Color lightBlue = const Color(0xFF29B6F6);
  static Color deepPurple = Colors.deepPurple;
  static Color blueGrey = const Color(0xFF78909C);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);

}