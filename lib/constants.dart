import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF232836),
  primaryColor: Colors.white,
  focusColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF232836),
    iconTheme:  IconThemeData(
      color: Colors.yellow,
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF232836),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: Colors.white,
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    hintStyle: TextStyle(
      color: Color.fromRGBO(255, 235, 59, 0.3),
    ),
    filled: true,
    fillColor: Color.fromRGBO(45, 51, 62, 80),
    prefixIconColor: Colors.yellow,
    suffixIconColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    headline1: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline2: TextStyle(
      color: Colors.white70,
      fontSize: 13,
    ),
    headline3: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w800,
    ),
    headline4: TextStyle(
      fontSize: 30,
      color: Colors.white,
      fontWeight: FontWeight.w800,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 5,
    selectedItemColor: Colors.yellow,
    selectedIconTheme: IconThemeData(
      opacity: 1,
      size: 30,
    ),
    unselectedIconTheme: IconThemeData(
      opacity: 0.5,
    ),
    unselectedItemColor: Colors.white54,
    backgroundColor: Color(0xFF232836),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  );



// The Light Theme
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[100],
  primaryColor: const Color(0xFFF5564B),

  focusColor: const Color(0xFFF5564B),

  appBarTheme:  AppBarTheme(
    backgroundColor:Colors.grey[100],
    iconTheme: const IconThemeData(
      color: Color(0xFFF5564B),
    ),
    elevation: 0,
    systemOverlayStyle:const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF232836),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: Colors.white,
    labelStyle: TextStyle(
      color: Color(0xFFF5564B),
    ),
    hintStyle: TextStyle(
      color: Color.fromRGBO(246, 86, 76, 0.3),
    ),
    filled: true,
    fillColor: Colors.white70,
    prefixIconColor: Color(0xFFF5564B),
    suffixIconColor: Color(0xFFF5564B),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(

        Radius.circular(10),
      ),

    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
    headline1: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    headline2: TextStyle(
      color: Color(0xFFBFBFBF),
      fontSize: 13,
    ),
    headline3: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w800,
    ),
    headline4: TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 5,
    selectedItemColor: Color(0xFFF5564B),
    selectedIconTheme: IconThemeData(
      opacity: 1,
      size: 30,
    ),
    unselectedIconTheme: IconThemeData(
      opacity: 0.5,
    ),
    unselectedItemColor: Colors.black45,
    backgroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),

);

const Color textButtonColor = Colors.yellow;
const Color inputTextColor = Colors.white;
