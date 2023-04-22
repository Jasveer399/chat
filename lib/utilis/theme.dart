import 'package:chat/utilis/elevaterb.dart';
import 'package:chat/utilis/text_deco.dart';
import 'package:flutter/material.dart';

class ATheme{

  static ThemeData lighttheme=ThemeData(
    brightness: Brightness.light,
    elevatedButtonTheme: AppElevaterbutton.lighelevaterbutton,
    //outlinedButtonTheme: Appoutlinebutton.lightOutlinebutton,
    inputDecorationTheme: Logintextfiled.lighttheme,
  );

  static ThemeData darktheme=ThemeData(
    brightness: Brightness.dark,
    //elevatedButtonTheme: AppElivaterbutton.darkElivaterbutton,
    //outlinedButtonTheme: Appoutlinebutton.darktOutlinebutton,
    inputDecorationTheme: Logintextfiled.darkttextfield,
  );
}