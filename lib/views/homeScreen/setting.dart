import 'package:chat_app_nnt/helper/constants.dart';
import 'package:chat_app_nnt/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:chat_app_nnt/views/welcome.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    bool isSwitched;
    isDarkMode ? isSwitched = true : isSwitched = false;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF8438FD)
                      : const Color(0xffb73c41),
                  borderRadius: BorderRadius.circular(140),
                ),
                child: Text(
                  Constants.myName
                      .toString()
                      .replaceAll("name: ", "")
                      .substring(0, 1),
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? const Color(0xff222222)
                        : const Color(0xffffeddf),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                Constants.myName.toString().replaceAll("name: ", ""),
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? const Color(0xFFFFEDDF)
                      : const Color(0xFF222222),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0, bottom: 42.5),
              child: Text(
                Constants.myEmail.toString().replaceAll("email: ", ""),
                style: TextStyle(
                  fontFamily: 'Arial Rounded MT Bold',
                  fontSize: 20,
                  color: isDarkMode
                      ? const Color(0xFF93A7FF)
                      : const Color(0xff685374),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: isDarkMode
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF052ACE),
                              Color(0xFF9554FD),
                            ],
                          )
                        : const LinearGradient(
                            colors: [
                              Color(0xffb63d42),
                              Color(0xFFFF8433),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(80)),
                child: Container(
                  width: 350,
                  height: 66,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.palette),
                      const SizedBox(width: 20),
                      const Text(
                        'Dark mode',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Arial Rounded MT Bold',
                        ),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                        inactiveColor: const Color(0xFF7E7E7E),
                        activeColor: const Color(0xFF4DC961),
                        width: 50.0,
                        height: 32.0,
                        valueFontSize: 25.0,
                        toggleSize: 24.0,
                        value: isSwitched,
                        borderRadius: 30.0,
                        padding: 2.0,
                        showOnOff: false,
                        onToggle: (val) {
                          setState(
                            () {
                              isSwitched = val;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: isDarkMode
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF052ACE),
                              Color(0xFF9554FD),
                            ],
                          )
                        : const LinearGradient(
                            colors: [
                              Color(0xffb63d42),
                              Color(0xFFFF8433),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(80)),
                child: Container(
                  width: 350,
                  height: 66,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.bell),
                      const SizedBox(width: 20),
                      const Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Arial Rounded MT Bold',
                        ),
                      ),
                      const Spacer(),
                      LineIcon(LineIcons.angleRight),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: isDarkMode
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF052ACE),
                              Color(0xFF9554FD),
                            ],
                          )
                        : const LinearGradient(
                            colors: [
                              Color(0xffb63d42),
                              Color(0xFFFF8433),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(80)),
                child: Container(
                  width: 350,
                  height: 66,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.language),
                      const SizedBox(width: 20),
                      const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Arial Rounded MT Bold',
                        ),
                      ),
                      const Spacer(),
                      LineIcon(LineIcons.angleRight),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 26),
              padding: const EdgeInsets.only(left: 90, right: 90),
              height: 75,
              child: ElevatedButton.icon(
                onPressed: () {
                  authMethods.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.signOutAlt),
                label: const Text(
                  'Sign out',
                  style: TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80), // <-- Radius
                  ),
                  primary: isDarkMode
                      ? const Color(0xFF8438FD)
                      : const Color(0xffB63d42),
                  onPrimary: const Color(0xFFFFF0DD),
                  textStyle: const TextStyle(
                      fontFamily: 'Arial Rounded MT Bold', fontSize: 20),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//tắt được ko m , đc chứ
