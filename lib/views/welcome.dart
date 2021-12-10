import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDB8b56), Color(0xffB63d42)],
  ).createShader(const Rect.fromLTWH(0, 0, 0, 0));
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              top: 0,
              right: 0,
              left: 0,
              bottom: (screenHeight - statusBarHeight) * 0.033),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF181818)
                            : const Color(0xffEDC796),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(0.0),
                            bottomLeft: Radius.circular(63.0)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 35, right: 10, left: 35, bottom: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'WELCOME ',
                              style: TextStyle(
                                fontSize: screenWidth * 0.10,
                                fontFamily: 'MADE Waffle Soft',
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? const Color(0XFFd3d3d3)
                                    : const Color(0xFF2A2A2A),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'TO ',
                              style: TextStyle(
                                fontSize: screenWidth * 0.11,
                                fontFamily: 'MADE Waffle Soft',
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? const Color(0XFFd3d3d3)
                                    : const Color(0xFF2A2A2A),
                              ),
                            ),
                            GradientText(
                              'BRANCHER',
                              style: TextStyle(
                                fontSize: screenWidth * 0.11,
                                fontFamily: 'MADE Waffle Soft',
                                fontWeight: FontWeight.bold,
                              ),
                              gradientType: GradientType.linear,
                              radius: 2.5,
                              colors: const [
                                Color(0XffE87A18),
                                Color(0XffB63D42),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 23, bottom: 40),
                          child: Text(
                            'From now on. we can have a great time together at Brancher forever',
                            style: TextStyle(
                              color: isDarkMode
                                  ? const Color(0xffd3d3d3)
                                  : const Color(0xFF2A2A2A),
                              fontSize: 15,
                              fontFamily: 'Hiragino Sans',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: (screenHeight - statusBarHeight) * 0.21,
                child: SvgPicture.asset(
                  'assets/images/welcome_main_pic.svg',
                  height: 500,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.only(left: 67, right: 67),
                height: 63,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                    primary: isDarkMode
                        ? const Color(0xFF8F2929)
                        : const Color(0xffB63d42),
                    onPrimary: isDarkMode
                        ? const Color(0xFFe9e9e9)
                        : const Color(0xFFFFF0DD),
                    textStyle: const TextStyle(
                        fontFamily: 'Arial Rounded MT Bold', fontSize: 20),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 67, right: 67),
                height: 63,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.facebookSquare),
                  label: const Text('Sign in with Facebook'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                    primary: isDarkMode
                        ? const Color(0xFF293C8F)
                        : const Color(0xFF3D49B6),
                    onPrimary: isDarkMode
                        ? const Color(0xFFe9e9e9)
                        : const Color(0xFFFFF0DD),
                    textStyle: const TextStyle(
                        fontFamily: 'Arial Rounded MT Bold', fontSize: 20),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 67),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInSreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Arial Rounded MT Bold',
                          fontSize: 25,
                          color: isDarkMode
                              ? const Color(0xffd3d3d3)
                              : const Color(0xff685374),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 67),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpSreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Arial Rounded MT Bold',
                          fontSize: 25,
                          color: isDarkMode
                              ? const Color(0xffd3d3d3)
                              : const Color(0xff685374),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
