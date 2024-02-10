import 'package:firebase_auth/firebase_auth.dart';
import 'fetch_data.dart';
import 'get_data.dart';
import 'signin_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
const color = const Color(0xFFB74093);
class _HomeScreenState extends State<HomeScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
            )
          ],
        ),
      body: GetData()
    );

  }
}