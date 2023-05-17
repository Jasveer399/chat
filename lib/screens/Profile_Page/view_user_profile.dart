import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/api/apis.dart';
import 'package:chat/helper/formatte_time.dart';
import 'package:chat/models/chat_user.dart';
import 'package:flutter/material.dart';

class View_Profile extends StatefulWidget {
  final ChatUaer user;
  const View_Profile({super.key, required this.user});

  @override
  State<View_Profile> createState() => _ViewProfile_PageState();
}

class _ViewProfile_PageState extends State<View_Profile> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Joined On: ',
            style: TextStyle(fontSize: 17, color: Colors.grey.shade400),
          ),
          Text(
            Formatte_time.getlastmassagetime(
                context: context, time: widget.user.createdAt,showyear: true),
            style: TextStyle(color: Colors.grey.shade400,fontSize: 16),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 18, 40, 57),
      body: StreamBuilder(
        stream: APIS.getuserinfo(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => ChatUaer.fromJson(e.data())).toList() ?? [];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * 0.045,
                ),
                Container(
                  color: Color.fromARGB(255, 3, 42, 71),
                  width: mq.width,
                  height: mq.height,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(mq.height * 0.1),
                          child: CachedNetworkImage(
                              width: mq.height * .15,
                              height: mq.height * .15,
                              fit: BoxFit.cover,
                              imageUrl: widget.user.image)),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      Text(
                        widget.user.name,
                        style: TextStyle(
                            fontSize: 25, color: Colors.grey.shade400),
                      ),
                      SizedBox(
                        height: mq.height * 0.03,
                      ),
                      Container(
                        height: mq.height * 0.015,
                        color: Color.fromARGB(255, 18, 40, 57),
                        width: mq.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 30),
                        child: Row(
                          children: [
                            Text(
                              'Email: ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade400),
                            ),
                            Text(
                              widget.user.email,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 25),
                        child: Row(
                          children: [
                            Text(
                              'About: ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade400),
                            ),
                            Text(
                              widget.user.about,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 25,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'ActiveTime: ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade400),
                            ),
                            Text(
                              list.isNotEmpty
                                  ? list[0].isOnline
                                      ? 'online'
                                      : Formatte_time.getlastActivetime(
                                          context: context,
                                          lastActive: list[0].lastActive)
                                  : Formatte_time.getlastActivetime(
                                      context: context,
                                      lastActive: widget.user.lastActive),
                              style: TextStyle(
                                fontSize: 18,
                                //fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.3,
                      ),
                      Container(
                        height: mq.height * 0.015,
                        color: Color.fromARGB(255, 18, 40, 57),
                        width: mq.width,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
