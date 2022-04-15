import 'package:flash_chat/components/roundedButton.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  static const String id = "registration-screen";
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.blueAccent,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          RegistrationPage(context),
          _loadingAnimation(),
        ],
      ),
    );
  }

  Widget _loadingAnimation() {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const SizedBox(
        height: 0.0,
      );
    }
  }

  Widget RegistrationPage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
            decoration: kTextFiedlDecoration.copyWith(
                hintText: "Enter your email",
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
            decoration: kTextFiedlDecoration.copyWith(
                hintText: "Enter your password",
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 24.0,
          ),
          roundedButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });

              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email!, password: password!);
                if (newUser != null) {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
                setState(() {
                  loading = false;
                });
              } catch (e) {
                print(e);
              }
            },
            title: "Register",
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
