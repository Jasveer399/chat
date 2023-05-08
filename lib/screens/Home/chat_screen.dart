import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/api/apis.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/models/massage_data.dart';
import 'package:chat/widgets/massage_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
//import 'package:flutter/services.dart';

class Chat_Screen extends StatefulWidget {
  final ChatUaer user;
  const Chat_Screen({super.key, required this.user});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  List<Massage> list = [];
  final _textcontroler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppprimeCl));
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppprimeCl,
        flexibleSpace: _appBar(),
      ),
      //backgroundColor: Color.fromARGB(255, 151, 172, 208),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: APIS.getallmassages(widget.user),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();

                  //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    //log('data: ${jsonEncode(data![0].data())}');
                    list =
                        data?.map((e) => Massage.fromJson(e.data())).toList() ??
                            [];
                    if (list.isNotEmpty) {
                      return ListView.builder(
                        
                        reverse: true,
                          //itemCount: _isScearch ? _sherchlist.length : list.length,
                          itemCount: list.length,
                          itemBuilder: (context, Index) {
                            return Massage_Card(
                              massage: list[Index],
                            );
                          });
                    } else {
                      return Center(
                          child: Text(
                        'Say hi! 👋',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 3, 42, 71)),
                      ));
                    }
                }
              },
            ),
          ),
          _chat_filed(),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        //back Botton
        Padding(
          padding: EdgeInsets.only(top: 48),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade400,
              )),
        ),

        //user Profile Pic
        Padding(
          padding: EdgeInsets.only(top: 48),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * 0.3),
            child: CachedNetworkImage(
              width: mq.height * .05,
              height: mq.height * .05,
              imageUrl: widget.user.image,
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(Icons.error)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 48, left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              ),
              Text(
                " Last Seen...",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  //maseage filed

  Widget _chat_filed() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  //for picking Emoji
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: AppprimeCl,
                        size: 26,
                      )),

                  Expanded(
                      child: TextField(
                    controller: _textcontroler,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: AppprimeCl,
                    decoration: const InputDecoration(
                      hintText: "Massage",
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(200.0))),
                    ),
                  )),

                  //for picking image from gallery
                  IconButton(
                      onPressed: () async {
                         final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);
                            for (var i in images) {
                              log("image path: ${i.path}");
                         await APIS.sendChatImage(widget.user, File(i.path));
                            }              
                      },
                      icon: Icon(
                        Icons.image,
                        color: AppprimeCl,
                        size: 26,
                      )),

                  //for take picture from camera
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera,imageQuality: 70);
                        if (image != null) {
                          log("image path: ${image.path}");
                         await APIS.sendChatImage(widget.user, File(image.path));
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt_sharp,
                        color: AppprimeCl,
                        size: 26,
                      )),
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: 0,
            padding: EdgeInsets.only(top: 8, bottom: 8, right: 4, left: 8),
            color: AppprimeCl,
            onPressed: () {
              if (_textcontroler.text.isNotEmpty) {
                APIS.sendmassage(widget.user, _textcontroler.text, Type.taxt);
                _textcontroler.text = '';
              }
            },
            child: Icon(
              Icons.send,
              color: Colors.grey.shade400,
            ),
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}
