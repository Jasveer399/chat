import 'dart:developer';
import 'dart:io';
import 'package:chat/models/chat_user.dart';
import 'package:chat/models/massage_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class APIS {
  static FirebaseAuth auth = FirebaseAuth.instance;
  final time = DateTime.now().millisecondsSinceEpoch.toString();

  //For stor data on Firebase_cloud
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for Uploading Image and file on firebase Storage

  static FirebaseStorage storage = FirebaseStorage.instance;

  // to return current user
  static User get user => auth.currentUser!;

  //for checking the user exists or not;
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  //for storing self info
  static late ChatUaer me;

  ChatUaer meinfo = ChatUaer(
    image: '',
    name: '',
    about: '',
    createdAt: '',
    lastActive: '',
    isOnline: false,
    id: '',
    email: '',
    pushToken: '',
  );

  //for geting self Info
  static Future<void> getselfinfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((user) => () async {
              if (user.exists) {
                me = ChatUaer.fromJson(user.data()!);
              } else {
                await creatuser().then((value) => getselfinfo());
              }
            });
  }

  //for creating a new user
  static Future<void> creatuser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatuser = ChatUaer(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        about: "Hi im useing Chatter",
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: user.uid,
        email: user.email.toString(),
        pushToken: time);

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatuser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>getalluser() {
    return firestore
        .collection('users')
        .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  //for updating the user data;
  static Future<void> updatinguserdata() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  //Updating profile image of user
  static Future<void> updatingprofilepic(File file) async {
    final ext = file.path.split('.').last;
    log('Extension:$ext');
    final ref = storage.ref().child('Profile_Pic/${user.uid}.$ext');

    ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      log('data Tranferred:${p0.bytesTransferred / 1000} kb');
    });
    me.image = await ref.getDownloadURL();
    await firestore.collection('users').doc(user.uid).update({
      'image': me.image,
    });
  }

  //************for Massage Filed APIS*********************//

//for geting all massage of a spacific conversation from firebase database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getallmassages(
      ChatUaer user) {
    return firestore
        .collection('chat/${getconversationid(user.id)}/massage')
        .orderBy('sent', descending: true)
        .snapshots();
  }

//usefull for get conversation id
  static String getconversationid(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  //for sanding a massage
  static Future<void> sendmassage(
      ChatUaer chatuser, String msg, Type type) async {
    //for massage sending time and also used as a id;
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //massage to send
    final Massage massage = Massage(
        toid: chatuser.id,
        msg: msg,
        read: '',
        type: type,
        fromid: user.uid,
        sent: time);

    final ref =
        firestore.collection('chat/${getconversationid(chatuser.id)}/massage');

    ref.doc(time).set(massage.toJson());
  }

  //for update read status massage
  static Future<void> updatereadmsgstatus(Massage massage) async {
    firestore
        .collection('chat/${getconversationid(massage.fromid)}/massage')
        .doc(massage.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //for geting last Massage
  static Stream<QuerySnapshot<Map<String, dynamic>>> getlastMassage(
      ChatUaer user) {
    return firestore
        .collection("chat/${getconversationid(user.id)}/massage")
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //for geting spacific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getuserinfo(
      ChatUaer chatuser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatuser.id)
        .snapshots();
  }

  //for updating online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  static Future<void> sendChatImage(ChatUaer chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getconversationid(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendmassage(chatUser, imageUrl, Type.image);
  }
}
