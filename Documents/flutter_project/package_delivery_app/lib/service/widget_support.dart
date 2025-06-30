import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle headlineTextfieldStyle(double textsize) {
    return TextStyle(color: Colors.black, fontSize: textsize, fontWeight: FontWeight.bold);
  }

  static TextStyle simpleTextfieldStyle() {
    return TextStyle(color: Colors.black38, fontSize: 18.0, fontWeight: FontWeight.w400);
  }
  static TextStyle slowSimpleTextfieldStyle() {
    return TextStyle(color: Colors.black38, fontSize: 15.0, fontWeight: FontWeight.w400);
  }
  static TextStyle whiteTextfieldStyle() {
    return TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300);
  }
  static TextStyle differentshadeWhiteTextfieldStyle() {
    return TextStyle(color: Colors.white54, fontSize: 17.0, fontWeight: FontWeight.w500);
  }
}
