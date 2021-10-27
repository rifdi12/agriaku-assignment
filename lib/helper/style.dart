import 'package:flutter/material.dart';

ThemeData themeData() {
  Color greyTextTitle = const Color(0xFF757575);
  Color greyText = const Color(0xFF5b5b5b);
  // Color whiteBg = const Color(0xFFFF6F00);

  return ThemeData(
    canvasColor: Color(0xff383838),
    primarySwatch: Colors.red,
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: greyTextTitle),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff2b2b2b),
      textTheme: TextTheme(
        headline6: TextStyle(color: greyTextTitle, fontSize: 20),
      ),
      iconTheme: IconThemeData(
        color: greyTextTitle,
      ),
    ),
    textTheme: TextTheme(
      // headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      // title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 12.0, color: greyText),
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        textTheme: ButtonTextTheme.primary,
        height: 40),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    ),
  );
}
