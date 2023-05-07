import 'package:flutter/material.dart';

class Dialogs {
  static void showsnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(81, 54, 133, 244),
    ));
  }

  static void showprogresbar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(child: CircularProgressIndicator()));
  }
  
}
