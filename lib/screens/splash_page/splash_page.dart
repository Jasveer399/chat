import 'package:chat/api/apis.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/images.dart';
import 'package:chat/screens/Home/home_page.dart';
import 'package:chat/screens/Login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash_Page extends StatefulWidget {
  const Splash_Page({super.key});

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent));
      if (APIS.auth.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home_Page()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Login_Page()));
      }
    });
  }

  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppprimeCl,
            Color.fromARGB(255, 125, 195, 252),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: mq.width * 25,
                height: mq.height * 0.28,
                child: Image(image: AssetImage(Appicon))),
            SizedBox(
              height: 300,
            ),
            Text(
              "Welcome Chatter",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      )),
    );
  }
}
