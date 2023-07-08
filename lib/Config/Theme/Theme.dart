import 'package:flutter/material.dart';

class Themes {
  static final principal = ThemeData(
    primaryColor: Colors.green,
    //useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
    //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
  );
  static const textcolor=Colors.green;
}

class Styles {
  static const styleAuthFailed=TextStyle(fontSize: 14,color: Colors.red);
 
}
