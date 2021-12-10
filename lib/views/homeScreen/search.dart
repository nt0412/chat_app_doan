import 'package:chat_app_nnt/helper/constants.dart';
import 'package:chat_app_nnt/services/database.dart';
import 'package:chat_app_nnt/views/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dartx/dartx.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  bool haveUserSearched = false;

  TextEditingController searchTextController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  late QuerySnapshot searchResultSnapshot;

  initiateSearch() async {
    if (searchTextController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .getUserByUsername(searchTextController.text)
          .then((val) {
        searchResultSnapshot = val;
        // ignore: avoid_print
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget searchList() {
    return haveUserSearched
        ? ListView.builder(
            itemCount: searchResultSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                searchResultSnapshot.docs[index]
                    .data()
                    .toString()
                    .substring(
                      searchResultSnapshot.docs[index]
                          .data()
                          .toString()
                          .indexOf('name: '),
                      searchResultSnapshot.docs[index]
                          .data()
                          .toString()
                          .indexOf('email'),
                    )
                    .replaceAll(',', ''),
                searchResultSnapshot.docs[index]
                    .data()
                    .toString()
                    .substring(
                      searchResultSnapshot.docs[index]
                          .data()
                          .toString()
                          .indexOf('email: '),
                      searchResultSnapshot.docs[index]
                          .data()
                          .toString()
                          .indexOf('}'),
                    )
                    .replaceAll(',', ''),
              );
            },
          )
        : Container();
  }

  //create conversation
  createChatRoomAndStartConversation(String userName) {
    List<String> users = [Constants.myName, userName];
    String chatRoomId = getChatRoomId(Constants.myName, userName);
    Map<String, dynamic> chatRoomMap = {
      "user": users,
      "chatRoomId": chatRoomId
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomScreen(
          chatRoomId: chatRoomId,
        ),
      ),
    );
  }

  Widget searchTile(String userName, String userEmail) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 23),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                userName.capitalize(),
                style: TextStyle(
                  color: isDarkMode
                      ? const Color(0xFFFBFBFB)
                      : const Color(0xFF171717),
                  fontSize: 16,
                  fontFamily: 'BeVietnamPro',
                ),
                maxLines: 1,
              ),
              AutoSizeText(
                userEmail.capitalize(),
                style: TextStyle(
                  color: isDarkMode
                      ? const Color(0xFFFBFBFB)
                      : const Color(0xFF171717),
                  fontSize: 16,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(userName);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF0935FB),
                          Color(0xFFA06AF7),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                      )
                    : const LinearGradient(
                        colors: [
                          Color(0xfffb9109),
                          Color(0xFFF76A6A),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                      ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Container(
                alignment: FractionalOffset.center,
                child: const Text(
                  "Message",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      // ignore: unnecessary_string_escapes
      return "$b\_$a";
    } else {
      // ignore: unnecessary_string_escapes
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: NewGradientAppBar(
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xffffeddf), //change your color here
        ),
        centerTitle: true,
        title: const Text(
          'Find your friend',
          style: TextStyle(
            color: Color(0xffffeddf),
            fontFamily: 'Arial Rounded MT Bold',
            fontSize: 19,
          ),
        ),
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: searchTextController,
                      style: const TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontSize: 18,
                        color: Color(0xFFFFF0DD),
                      ),
                      cursorWidth: 2,
                      cursorColor: const Color(0xAFFFF0DD),
                      decoration: const InputDecoration(
                        hintText: 'Search to get new friend...',
                        hintStyle: TextStyle(
                          color: Color(0xAFFFF0DD),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: isDarkMode
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF0935FB),
                                  Color(0xFFA06AF7),
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  Color(0xfffb9109),
                                  Color(0xFFF76A6A),
                                ],
                              ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.search,
                        color: Color(0xFFFFF0DD),
                      ),
                    ),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}
