import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/roundedButton.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const String id = "login-screen";
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String? email;
  String? password;

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
          LoginPage(context),
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

  Widget LoginPage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                final newUser = await _auth.signInWithEmailAndPassword(
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
            title: "Log In",
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
