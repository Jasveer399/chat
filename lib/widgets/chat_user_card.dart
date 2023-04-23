import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/models/chat_user.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUaer user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    
   final mq=MediaQuery.of(context).size;
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height*0.3),
            child: CachedNetworkImage(
              width: mq.height*.055,
              height: mq.height*.055,
              imageUrl: widget.user.image,
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(Icons.error)),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about),
          trailing: Text('12.00 PM'),
        ),
      ),
    );
  }
}
