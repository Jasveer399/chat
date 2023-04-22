import 'package:chat/constants/colors.dart';
import 'package:flutter/material.dart';

class AppElevaterbutton{
  AppElevaterbutton();

  static final lighelevaterbutton= ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppWhiteCl,
      backgroundColor: Color.fromARGB(181, 133, 166, 215),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
    ),
  );
}