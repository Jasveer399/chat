//import 'dart:convert';
//import 'dart:developer';
import 'package:chat/api/apis.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/screens/Profile_Page/profile_page.dart';
import 'package:chat/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<ChatUaer> list = [];
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    ////final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Chatter",
            style: TextStyle(color: Colors.grey.shade400),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () async {
                 Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile_Page(user: list[0],)));
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade400,
                )),
          ],
          //elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 3, 42, 71),
        ),

       
        body: StreamBuilder(
          stream: APIS.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
              final data = snapshot.data?.docs;
               list=data?.map((e) => ChatUaer.fromJson(e.data())).toList() ??[];

           if(list.isNotEmpty){
             return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, Index) {
                  //log(data?.map((e) => ChatUaer.fromJson(e.data())).toList());
                  return ChatUserCard(user: list[Index],);
                  //return Text('Name: ${list[Index]}');
                });
           }
           else{
            return Center(child: Text('No User Found',style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 3, 42, 71)),));
           }

          },
        ));
  }
}
