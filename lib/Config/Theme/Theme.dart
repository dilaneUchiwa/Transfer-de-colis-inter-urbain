import 'package:flutter/material.dart';

class Themes {
  static final principal = ThemeData(
    primaryColor: Colors.blue.shade900,
    //useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900)
    //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
  );
  static const textcolor=Colors.blue;
}

class Styles {
  static const styleAuthFailed=TextStyle(fontSize: 14,color: Colors.red);
 
}
