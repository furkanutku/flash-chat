import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/roundedButton.dart';

class WelcomeScreen extends StatefulWidget {
  // final String furkan;

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static const String id = "welcome-screen";
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    // animation = ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);

    animation = CurvedAnimation(parent: controller!, curve: Curves.ease);

    controller!.forward();

    controller!.addListener(() {
      //controller.value değerini addListener içinde dinleyebiliriz
      //setstate çalıştırarak da value değişimlerini build fonksiyonuna iletmiş oluruz ve sayfa yenilenir.
      setState(() {});
      // print(animation!.value);
      //print(controller.value);
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(controller!.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation!.value * 60,
                  ),
                ),
                AnimatedTextKit(
                  pause: const Duration(milliseconds: 500),
                  totalRepeatCount: 3,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      speed: const Duration(milliseconds: 200),
                      textStyle: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            roundedButton(
              color: Colors.lightBlueAccent,
              title: ("Log In"),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            roundedButton(
              color: Colors.blueAccent,
              title: ("Register"),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
