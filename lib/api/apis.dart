import 'package:chat/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIS {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //For stor data on Firebase_cloud
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to return current user
  static User get user => auth.currentUser!;

  //for checking the user exists or not;
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
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

    return await firestore.collection('users').doc(user.uid).set(chatuser.toJson());
            
  }
}
