import 'package:chat/constants/colors.dart';
import 'package:flutter/material.dart';

class Logintextfiled{
   Logintextfiled();

   static InputDecorationTheme lighttheme = InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppsecondaryCl),
    //prefixIconColor: AppsecondaryCl,
    suffixIconColor: AppsecondaryCl,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(200.0))),
    border: OutlineInputBorder(
        borderSide: BorderSide(
          color:Colors.white,
          width: 1.0,
        ),
       borderRadius: BorderRadius.all(Radius.circular(100.0)),
       ),
   );
  
   static InputDecorationTheme darkttextfield = InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: AppprimeCl),
    //prefixIconColor: AppprimeCl,
    suffixIconColor: AppprimeCl,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppprimeCl,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(100.0))),
    border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(100.0))),
  );
}
