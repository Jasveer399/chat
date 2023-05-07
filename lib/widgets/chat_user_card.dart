import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/api/apis.dart';
import 'package:chat/helper/formatte_time.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/models/massage_data.dart';
import 'package:chat/screens/Home/chat_screen.dart';
import 'package:chat/screens/Home/home_page.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUaer user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Massage? _massage;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Chat_Screen(
                        user: widget.user,
                      )));
        },
        child: StreamBuilder(
            stream: APIS.getlastMassage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Massage.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) _massage = list[0];

              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * 0.3),
                  child: CachedNetworkImage(
                    width: mq.height * .055,
                    height: mq.height * .055,
                    imageUrl: widget.user.image,
                    //placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        CircleAvatar(child: Icon(Icons.error)),
                  ),
                ),
                title: Text(widget.user.name),
                subtitle:
                    Text(_massage != null ? _massage!.msg : widget.user.about),
                trailing: _massage == null
                    ? null
                    : _massage!.read.isEmpty &&
                            _massage!.fromid != APIS.user.uid
                        ? Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                        : Text(
                            Formatte_time.getformattedtime(
                                context: context, time: _massage!.sent),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
              );
            }),
      ),
    );
  }
}
