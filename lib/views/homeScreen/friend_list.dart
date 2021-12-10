import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chat_app_nnt/views/chat_room.dart';

TextEditingController searchBoxController = TextEditingController();

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ChatRoomScreen(),
                //   ),
                // );
              },
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/03/03/20/42/man-657869_1280.jpg'),
              ),
              title: Text(
                'Nguyen Nam Thuan',
                style: TextStyle(
                  fontFamily: 'Arial Rounded MT Bold',
                  fontSize: 18,
                  color: isDarkMode
                      ? const Color(0xffffeddf)
                      : const Color(0xff222222),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.comment,
                size: 30,
                color: Colors.teal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ChatRoomScreen(),
                //   ),
                // );
              },
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/03/03/20/42/man-657869_1280.jpg'),
              ),
              title: Text(
                'Nguyen Nam Thuan',
                style: TextStyle(
                  fontFamily: 'Arial Rounded MT Bold',
                  fontSize: 18,
                  color: isDarkMode
                      ? const Color(0xffffeddf)
                      : const Color(0xff222222),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.comment,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ChatRoomScreen(),
                //   ),
                // );
              },
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/03/03/20/42/man-657869_1280.jpg'),
              ),
              title: Text(
                'Nguyen Nam Thuan',
                style: TextStyle(
                  fontFamily: 'Arial Rounded MT Bold',
                  fontSize: 18,
                  color: isDarkMode
                      ? const Color(0xffffeddf)
                      : const Color(0xff222222),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.comment,
                size: 30,
                color: Colors.teal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ChatRoomScreen(),
                //   ),
                // );
              },
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/03/03/20/42/man-657869_1280.jpg'),
              ),
              title: Text(
                'Nguyen Nam Thuan',
                style: TextStyle(
                  fontFamily: 'Arial Rounded MT Bold',
                  fontSize: 18,
                  color: isDarkMode
                      ? const Color(0xffffeddf)
                      : const Color(0xff222222),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.comment,
                size: 30,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//tắt được ko m , đc chứ
