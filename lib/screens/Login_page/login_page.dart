import 'dart:developer';
import 'dart:io';
import 'package:chat/api/apis.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/size.dart';
import 'package:chat/helper/dialog.dart';
import 'package:chat/screens/Home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  _handlegooglebtclick() {
    Dialogs.showprogresbar(context);
    _signInWithGoogle().then((User) async {
      Navigator.pop(context);

    // checking Your  Exists or Not  
      if ((await APIS.userExists())) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home_Page()));
      }else{
        APIS.creatuser();
         Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home_Page()));
      }

    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIS.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showsnackbar(
          context, 'something went wrong please Check your Internet');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppprimeCl,
            Color.fromARGB(255, 125, 195, 252),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppdefultSz),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 55,
                ),
                //Image(height: size.height * 0.2, image: AssetImage(Appicon)),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 65,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: TextField(
                    decoration: InputDecoration(
                        //fillColor: Colors.white,
                        //labelText: "Enter Email",
                        hintText: "Enter you Email",
                        prefixIcon: Icon(Icons.email_outlined)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      //labelText: "Enter Password",
                      hintText: "Enter you Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                ),
                SizedBox( 
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget your Password?",
                      style: TextStyle(fontSize: 18, color: AppsecondaryCl),
                    )),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.13,
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppprimeCl,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text(
                        "or connect with",
                        style: TextStyle(
                            color: AppprimeCl,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Container(
                        width: size.width * 0.13,
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppprimeCl,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      width: 155,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 66, 103, 178),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "    f",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "   Facebook",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: ()=>_handlegooglebtclick(),
                      child: Container(
                        width: 155,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppsecondaryCl,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "    G",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "   Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: AppsecondaryCl,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("Sign Up",
                            style:
                                TextStyle(color: AppprimeCl, fontSize: 25))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
