import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: userName)
        .get()
        // ignore: invalid_return_type_for_catch_error, avoid_print
        .catchError((e) => print(e.toString()));
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get()
        // ignore: invalid_return_type_for_catch_error, avoid_print
        .catchError((e) => print(e.toString()));
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance
        .collection("users")
        .add(userMap)
        // ignore: invalid_return_type_for_catch_error, avoid_print
        .catchError((e) => print(e.toString()));
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        // ignore: avoid_print
        .catchError((e) => print(e.toString()));
  }

  getConverationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  Future<void>? addConverationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)

        // ignore: invalid_return_type_for_catch_error, avoid_print
        .catchError((e) => print(e.toString()));
  }

  getChatRoom(String userName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("user", arrayContains: userName)
        .snapshots();
  }
}
