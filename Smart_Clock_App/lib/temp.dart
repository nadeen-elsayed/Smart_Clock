import 'package:flutter/material.dart';
class MyTextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text("Text Widget Example")
      ),
      body: Center(
          child:Text("Welcome to Javatpoint")
      ),
    );
  }
} 