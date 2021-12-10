import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'package:chat_app_nnt/helper/constants.dart';
import 'package:chat_app_nnt/services/database.dart';

import 'homeScreen/home.dart';

// ignore: must_be_immutable
class ChatRoomScreen extends StatefulWidget {
  String chatRoomId;
  ChatRoomScreen({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();

  late Stream<QuerySnapshot> chatMessageStream;

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                reverse: false,
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: (snapshot.data! as QuerySnapshot).docs[index]
                        ["message"],
                    isSendByMe: (snapshot.data! as QuerySnapshot).docs[index]
                            ["sendBy"] ==
                        Constants.myName,
                  );
                },
              )
            : Container();
      },
    );
  }

  addMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().toString(),
      };
      DatabaseMethods().addConverationMessages(widget.chatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getConverationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: NewGradientAppBar(
        actions: <Widget>[
          IconButton(
            icon: LineIcon(
              LineIcons.phone,
              color: const Color(0xFFF8DDC9),
              size: 28,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: LineIcon(
              LineIcons.video,
              color: const Color(0xFFF8DDC9),
              size: 28,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: LineIcon(
              LineIcons.verticalEllipsis,
              color: const Color(0xFFF8DDC9),
              size: 28,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        leading: IconButton(
            icon: LineIcon(
              LineIcons.angleLeft,
              size: 28,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()))),
        iconTheme: const IconThemeData(
          color: Color(0xffffeddf), //change your color here
        ),
        title: const Text(
          'Tran Anh Pha',
          style: TextStyle(
            color: Color(0xFFF8DDC9),
            fontSize: 20,
            fontFamily: 'BeVietnamPro',
          ),
        ),
        gradient: isDarkMode
            ? const LinearGradient(
                colors: [
                  Color(0xFF0049BE),
                  Color(0xFF903CB7),
                ],
              )
            : const LinearGradient(
                colors: [
                  Color(0xfffb9109),
                  Color(0xffb73c41),
                ],
              ),
      ),
      body: Stack(
        children: [
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF4e4e4e),
                          Color(0xFF4e4e4e),
                        ],
                      )
                    : const LinearGradient(
                        colors: [
                          Color(0xFFFFD7B8),
                          Color(0xFFF8D9C2),
                        ],
                      ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: messageController,
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontSize: 18,
                        color: isDarkMode
                            ? const Color(0xFFFBFBFB)
                            : const Color(0xFF171717),
                      ),
                      cursorWidth: 2,
                      cursorColor: const Color(0xAFFFF0DD),
                      decoration: InputDecoration(
                        hintText: 'Type something...',
                        hintStyle: TextStyle(
                          color: isDarkMode
                              ? const Color(0xFFFBFBFB)
                              : const Color(0xFF171717),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      addMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: isDarkMode
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF919191),
                                  Color(0xFF919191),
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  Color(0xFFFBDDC6),
                                  Color(0xFFF1CBAE),
                                ],
                              ),
                      ),
                      child: LineIcon(
                        LineIcons.telegramPlane,
                        color: isDarkMode
                            ? const Color(0xFFFBFBFB)
                            : const Color(0xFF171717),
                        size: 28,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({Key? key, required this.message, required this.isSendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      width: screenWidth,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          borderRadius: isSendByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(25),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(25),
                ),
          gradient: isSendByMe
              ? LinearGradient(
                  colors: [
                    isDarkMode
                        ? const Color(0xFF0049BE)
                        : const Color(0xfffb9109),
                    isDarkMode
                        ? const Color(0xFF903CB7)
                        : const Color(0xFFF76A6A),
                  ],
                )
              : LinearGradient(
                  colors: [
                    isDarkMode
                        ? const Color(0xFF626262)
                        : const Color(0xFFDADADA),
                    isDarkMode
                        ? const Color(0xFF424242)
                        : const Color(0xFFE0E0E0),
                  ],
                ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color:
                isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF353535),
          ),
        ),
      ),
    );
  }
}
