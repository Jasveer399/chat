import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/api/apis.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/screens/Login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile_Page extends StatefulWidget {
  final ChatUaer user;
  const Profile_Page({super.key, required this.user});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.grey.shade400),
        ),
        backgroundColor: Color.fromARGB(255, 3, 42, 71),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: mq.width,
                height: mq.height * 0.06,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * 0.1),
                  child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.fill,
                      imageUrl: widget.user.image)),
              SizedBox(
                height: mq.height * 0.02,
              ),
              Text(
                widget.user.name,
                style: TextStyle(
                    color: Color.fromARGB(255, 3, 42, 71),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    //fillColor: Colors.white,
                    labelText: "Name",
                    hintText: "Enter you Email",
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(
                height: mq.height * 0.04,
              ),
              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                    //fillColor: Colors.white,
                    labelText: "About",
                    hintText: "Enter you Email",
                    prefixIcon: Icon(Icons.info_outline)),
              ),
              SizedBox(
                height: mq.height * 0.04,
              ),
              SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                      label: Text(
                        'UpDate',
                        style: TextStyle(fontSize: 18),
                      ))),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () async {
          await APIS.auth.signOut();
          GoogleSignIn().signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Login_Page()));
        },
        label: Text('Logout'),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
