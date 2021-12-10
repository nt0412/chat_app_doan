import 'package:chat_app_nnt/helper/constants.dart';
import 'package:chat_app_nnt/helper/helperfunctions.dart';
import 'package:chat_app_nnt/services/auth.dart';
import 'package:chat_app_nnt/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_nnt/views/chat_room.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  late Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                    userName: (snapshot.data! as QuerySnapshot)
                        .docs[index]["chatRoomId"]
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, "")
                        .replaceAll("name:", ""),
                    chatRoomId: (snapshot.data! as QuerySnapshot).docs[index]
                        ["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    Constants.myEmail = (await HelperFunctions.getUserEmailSharedPreference())!;
    databaseMethods.getChatRoom(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
        // ignore: avoid_print
        print(
            "we got the data + ${chatRoomStream.toString()} this is name ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatRoomList(),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  const ChatRoomTile(
      {Key? key, required this.userName, required this.chatRoomId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
              chatRoomId: chatRoomId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFFCECECE)
                    : const Color(0xffb73c41),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Text(
                userName.substring(0, 2).replaceAll(" ", ""),
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: isDarkMode
                      ? const Color(0xFF222222)
                      : const Color(0xffFFF0DD),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5,
                    color: isDarkMode
                        ? const Color(0xffFFF0DD)
                        : const Color(0xff222222),
                  ),
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 15,
                    color: isDarkMode
                        ? const Color(0xffFFF0DD)
                        : const Color(0xff222222),
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              "11:00",
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 15,
                color: isDarkMode
                    ? const Color(0xffFFF0DD)
                    : const Color(0xff222222),
              ),
            )
          ],
        ),
      ),
    );
  }
}
