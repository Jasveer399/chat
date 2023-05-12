import 'package:chat/models/chat_user.dart';
import 'package:chat/screens/Profile_Page/profile_page.dart';
import 'package:chat/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../api/apis.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  //for Storing The Users Data
  List<ChatUaer> _list = [];
  //for Storing The Searching data
  final List<ChatUaer> _sherchlist = [];
//for storing search status
  bool _isScearch = false;

  @override
  void initState() {
    super.initState();
    APIS.getselfinfo();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChannels.lifecycle.setMessageHandler((message){
      
      if(message.toString().contains('resume')) APIS.updateActiveStatus(true);
      if(message.toString().contains('pause')) APIS.updateActiveStatus(false);
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    ////final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(_isScearch){
            setState(() {
              _isScearch=!_isScearch;
            });
            return Future.value(false);
          }
          else{
              return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: _isScearch
                  ? TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      autofocus: true,
                      style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                      onChanged: (val) {
                         _sherchlist.clear();
                        for (var i in _list) {
                          if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                              i.email.toLowerCase().contains(val.toLowerCase())) {
                            _sherchlist.add(i);
                          }
                          setState(() {
                            _sherchlist;
                          });
                        }
                      },
                    )
                  : Text(
                      "Chatter",
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isScearch = !_isScearch;
                      });
                    },
                    icon: Icon(_isScearch ? Icons.clear_rounded : Icons.search)
                    //color: Colors.grey.shade400,
                    ),
                IconButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Profile_Page(user:_list[0])));
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
              stream: APIS.getalluser(),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                _list = data?.map((e) => ChatUaer.fromJson(e.data())).toList() ?? [];
                if (_list.isNotEmpty) {
                  return ListView.builder(
                      itemCount: _isScearch ? _sherchlist.length : _list.length,
                      itemBuilder: (context, Index) {
                        //og(data?.map((e) => ChatUaer.fromJson(e.data())).toList());
                        return ChatUserCard(
                          user: _isScearch ? _sherchlist[Index] : _list[Index],
                        );
                        //return Text('Name: ${list[Index]}');
                      });
                } else {
                  return Center(
                      child: Text(
                    'No User Found',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 3, 42, 71)),
                  ));
                }
              },
            )),
      ),
    );
  }
}
