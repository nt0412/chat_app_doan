import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chat_list.dart';
import 'friend_list.dart';
import 'setting.dart';
import 'search.dart';

TextEditingController searchBoxController = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: NewGradientAppBar(
          leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.search,
              size: 23,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xffffeddf), //change your color here
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
          title: GestureDetector(
              child: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            ),
            child: const Text(
              'Searching...',
              style: TextStyle(
                  color: Color(0xF3DDDCDB),
                  fontFamily: 'Arial Rounded MT Bold',
                  fontSize: 18),
            ),
          )),
          elevation: 0.0,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: FaIcon(FontAwesomeIcons.comment),
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.users),
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.cog),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatListScreen(),
            FriendListScreen(),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}
//tắt được ko m , đc chứ
