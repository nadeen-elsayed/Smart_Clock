import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modernlogintute/view-model/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modernlogintute/signin_screen.dart';
import 'package:flutter/material.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void signUserOut() {

    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SignInScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body:  IconButton(
      onPressed: signUserOut,
      icon: Icon(Icons.logout),
    )
    );
  }
}

