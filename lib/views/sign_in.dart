import 'package:chat_app_nnt/services/auth.dart';
import 'package:chat_app_nnt/services/database.dart';
import 'package:chat_app_nnt/views/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:the_validator/the_validator.dart';
import 'sign_up.dart';
import 'package:chat_app_nnt/views/homeScreen/home.dart';
import 'package:chat_app_nnt/helper/helperfunctions.dart';

bool _passwordVisible = true;

class SignInSreen extends StatefulWidget {
  const SignInSreen({Key? key}) : super(key: key);

  @override
  _SignInSreenState createState() => _SignInSreenState();
}

class _SignInSreenState extends State<SignInSreen> {
  TextEditingController userLoginEmailController = TextEditingController();
  TextEditingController userLoginPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;
  late QuerySnapshot snapshotUserInfo;

  signIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signInWithEmailAndPassword(
              userLoginEmailController.text, userLoginPasswordController.text)
          .then((value) async {
        if (value != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          QuerySnapshot snapshotUserInfo = await DatabaseMethods()
              .getUserByUserEmail(userLoginEmailController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);

          HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0]
                .data()
                .toString()
                .substring(
                  snapshotUserInfo.docs[0].data().toString().indexOf('name:'),
                  snapshotUserInfo.docs[0].data().toString().indexOf('email'),
                )
                .replaceAll(',', ''),
          );
          HelperFunctions.saveUserEmailSharedPreference(
            snapshotUserInfo.docs[0]
                .data()
                .toString()
                .substring(
                  snapshotUserInfo.docs[0].data().toString().indexOf('email:'),
                  snapshotUserInfo.docs[0].data().toString().indexOf('}'),
                )
                .replaceAll(',', ''),
          );
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NewGradientAppBar(
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            size: 30,
          ),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              )),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xffffeddf), //change your color here
        ),
        centerTitle: true,
        title: const Text(
          'Sign in',
          style: TextStyle(
            color: Color(0xffffeddf),
            fontSize: 22,
            fontFamily: 'MADE Waffle Soft',
            fontWeight: FontWeight.bold,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            isDarkMode ? const Color(0xff383838) : const Color(0xfffb9109),
            isDarkMode ? const Color(0xff383838) : const Color(0xffb73c41),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 137,
                    left: -330,
                    right: 0,
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isDarkMode
                            ? const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF383838),
                                  Color(0xFF646464),
                                  Color(0xffbdbdbd),
                                ],
                              )
                            : const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xfffbe8d7),
                                  Color(0xFFFFE6D1),
                                  Color(0xFFF7B663),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 50, right: 40, left: 40, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText(
                          'Hello.',
                          style: TextStyle(
                            fontSize: screenWidth * 0.18,
                            fontFamily: 'MADE Waffle Soft',
                            fontWeight: FontWeight.bold,
                          ),
                          gradientType: GradientType.linear,
                          colors: [
                            isDarkMode
                                ? const Color(0Xffb63d42)
                                : const Color(0XffB63D42),
                            isDarkMode
                                ? const Color(0Xffbd5055)
                                : const Color(0xffB63d42),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 65),
                          child: Column(
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: userLoginEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: FieldValidator.email(
                                        message:
                                            "Please, input a valid email !",
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(' ')
                                      ],
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                        fontFamily: 'Arial Rounded MT Bold',
                                        fontSize: 20,
                                        color: isDarkMode
                                            ? const Color(0xffe9c5c6)
                                            : const Color(0xff685374),
                                      ),
                                      cursorWidth: 2,
                                      cursorColor: isDarkMode
                                          ? const Color(0xffe9c5c6)
                                          : const Color(0xff685374),
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Harabara Mais Demo',
                                          color: isDarkMode
                                              ? const Color(0xffe9c5c6)
                                              : const Color(0xff685374),
                                          fontSize: 19,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: isDarkMode
                                                ? const Color(0xffe9c5c6)
                                                : const Color(0xff685374),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: isDarkMode
                                                ? const Color(0xffe9c5c6)
                                                : const Color(0xff685374),
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.only(top: 0),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                      validator: FieldValidator.required(
                                          message: "Need password to sign in"),
                                      controller: userLoginPasswordController,
                                      style: TextStyle(
                                        fontFamily: 'Arial Rounded MT Bold',
                                        fontSize: 20,
                                        color: isDarkMode
                                            ? const Color(0xffe9c5c6)
                                            : const Color(0xff685374),
                                      ),
                                      cursorWidth: 2,
                                      cursorColor: isDarkMode
                                          ? const Color(0xffe9c5c6)
                                          : const Color(0xff685374),
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Harabara Mais Demo',
                                          color: isDarkMode
                                              ? const Color(0xffe9c5c6)
                                              : const Color(0xff685374),
                                          fontSize: 19,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: isDarkMode
                                                ? const Color(0xffe9c5c6)
                                                : const Color(0xff685374),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: isDarkMode
                                                ? const Color(0xffe9c5c6)
                                                : const Color(0xff685374),
                                          ),
                                        ),
                                        suffix: IconButton(
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                          icon: FaIcon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? FontAwesomeIcons.eye
                                                : FontAwesomeIcons.eyeSlash,
                                            color: isDarkMode
                                                ? const Color(0xffe9c5c6)
                                                : const Color(0xff685374),
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.only(top: 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 70, bottom: 80),
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        signIn();
                                      },
                                      child: const Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontFamily: 'Harabara Mais Demo',
                                          fontSize: 28,
                                          color: Color(0xffdb8b56),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        signIn();
                                      },
                                      child: const Icon(
                                        LineIcons.angleRight,
                                        color: Color(0xffffeddf),
                                        size: 35,
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          const CircleBorder(),
                                        ),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(17),
                                        ),
                                        backgroundColor: isDarkMode
                                            ? MaterialStateProperty.all(
                                                const Color(0xff4e4e4e),
                                              )
                                            : MaterialStateProperty.all(
                                                const Color(0xffB63d42),
                                              ),
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return const Color(0xffdb8b56);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 50),
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpSreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                            fontFamily: 'Arial Rounded MT Bold',
                                            fontSize: screenWidth * 0.05,
                                            color: isDarkMode
                                                ? const Color(0xff95879e)
                                                : const Color(0xff685374),
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot password ?',
                                        style: TextStyle(
                                            fontFamily: 'Arial Rounded MT Bold',
                                            fontSize: screenWidth * 0.05,
                                            color: isDarkMode
                                                ? const Color(0xff95879e)
                                                : const Color(0xff685374),
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
