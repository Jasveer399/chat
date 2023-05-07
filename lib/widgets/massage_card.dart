//import 'dart:math';
import 'dart:developer';
import 'package:chat/api/apis.dart';
import 'package:chat/helper/formatte_time.dart';
import 'package:chat/main.dart';
import 'package:chat/models/massage_data.dart';
import 'package:flutter/material.dart';

class Massage_Card extends StatefulWidget {
  const Massage_Card({super.key, required this.massage});

  final Massage massage;
  @override
  State<Massage_Card> createState() => _Massage_CardState();
}

class _Massage_CardState extends State<Massage_Card> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return APIS.user.uid == widget.massage.fromid
        ? _usermassage()
        : _sendermassage();
  }

  Widget _sendermassage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.height * 0.03, vertical: mq.height * 0.01),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 249, 233, 161)),
                  color: Color.fromARGB(255, 244, 240, 223),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Text(
                widget.massage.msg,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: mq.width * .04),
            child: Text(
              Formatte_time.getformattedtime(
                  context: context, time: widget.massage.sent),
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _usermassage() {
    //for upsate read status
   if(widget.massage.read.isEmpty){
    APIS.updatereadmsgstatus(widget.massage);
   }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //for addind some space
              SizedBox(
                width: mq.width * 0.02,
              ),
              //For Adding check bottonX
              if (widget.massage.read.isNotEmpty)
                Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

              //for Adding Some space
              SizedBox(
                width: mq.width * 0.01,
              ),
              Text(
                Formatte_time.getformattedtime(
                    context: context, time: widget.massage.sent),
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.height * 0.03, vertical: mq.height * 0.01),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 159, 169, 247)),
                  color: Color.fromARGB(255, 208, 213, 250),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Text(
                widget.massage.msg,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
