import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:modernlogintute/config/router/router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}
bool isVisible = false;
class MainScreenState extends State<MainScreen> {

  int _selectedScreenIndex = 1;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(FirebaseAuth.instance.currentUser != null) {
// signed in
      isVisible = true;
    } else {
// signed out
      isVisible = false;
    }
    return Scaffold(
      body: AppRouter().screens[_selectedScreenIndex],
      bottomNavigationBar: Visibility(
        visible: isVisible,
        child: BottomNavigationBar(
          currentIndex: _selectedScreenIndex ,
          onTap: _selectScreen,
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.search_favorite), label: ''),
            //BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: ''),
            BottomNavigationBarItem(icon: Icon(Iconsax.clock), label: ''),

            BottomNavigationBarItem(icon: Icon(Iconsax.setting), label: ''),
          ],
        ),
      ),
    );
  }
}
