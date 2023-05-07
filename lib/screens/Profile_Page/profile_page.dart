import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/api/apis.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/images.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/screens/Login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class Profile_Page extends StatefulWidget {
  final ChatUaer user;
  const Profile_Page({super.key, required this.user});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIS.getselfinfo();
  }

  String? _image;

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
              Stack(
                children: [
                  //Profile Picture
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(mq.height * 0.1),
                          child: Image.file(
                            File(_image!),
                            width: mq.height * .2,
                            height: mq.height * .2,
                            fit: BoxFit.cover,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(mq.height * 0.1),
                          child: CachedNetworkImage(
                              width: mq.height * .2,
                              height: mq.height * .2,
                              fit: BoxFit.cover,
                              imageUrl: widget.user.image)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            builder: (_) {
                              return ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    top: mq.height * 0.03,
                                    bottom: mq.height * 0.05),
                                children: [
                                  Text(
                                    "Add Profile Pic",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppprimeCl,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Pickinfg user profile image From gallery
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: CircleBorder(),
                                            fixedSize: Size(mq.width * 0.3,
                                                mq.height * 0.15),
                                            elevation: 1,
                                          ),
                                          onPressed: () async {
                                            final ImagePicker picker =
                                                ImagePicker();
                                            // Pick an image.
                                            final XFile? image =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image != null) {
                                              log("image path: ${image.path} -- Mine Type:${image.mimeType}");
                                              setState(() {
                                                _image = image.path;
                                              });
                                              APIS.updatingprofilepic(
                                                  File(_image!));
                                            }
                                            //for hiding bootom sheet
                                            Navigator.pop(context);
                                          },
                                          child: Image(
                                              image: AssetImage(Add_img_icon))),

                                      //Pickinfg user profile image From Camera
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: CircleBorder(),
                                            fixedSize: Size(mq.width * 0.3,
                                                mq.height * 0.15),
                                            elevation: 1,
                                          ),
                                          onPressed: () async {
                                            final ImagePicker picker =
                                                ImagePicker();
                                            // Pick an image.
                                            final XFile? image =
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                            if (image != null) {
                                              log("image path: ${image.path} -- Mine Type:${image.mimeType}");
                                              setState(() {
                                                _image = image.path;
                                              });
                                              APIS.updatingprofilepic(
                                                  File(_image!));
                                            }
                                            //for hiding bootom sheet
                                            Navigator.pop(context);
                                          },
                                          child: Image(
                                              image:
                                                  AssetImage(camera_img_icon)))
                                    ],
                                  ),
                                ],
                              );
                            });
                      },
                      elevation: 1,
                      shape: CircleBorder(),
                      child: Icon(Icons.edit),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
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
                        'UPDATE',
                        style: TextStyle(fontSize: 18),
                      ))),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () async {
          await APIS.auth.signOut().then((value) async => {
                await GoogleSignIn().signOut().then((value) => {
                      //for moving home secreen
                      Navigator.pop(context),

                      //for moving Loging Sereen
                      //Navigator.pop(context),
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => Login_Page())),
                    }),
              });
        },
        label: Text('Logout'),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
