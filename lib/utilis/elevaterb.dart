import 'package:chat/constants/colors.dart';
import 'package:flutter/material.dart';

class AppElevaterbutton{
  AppElevaterbutton();

  static final lighelevaterbutton= ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppWhiteCl,
      backgroundColor: AppprimeCl,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
    ),
  );
}