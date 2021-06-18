import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fms/admin/adminHome.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/screens/profile/body.dart';
import 'package:test_fms/sevices/auth.dart';


class AdminProfile extends StatefulWidget {
  static String id = "AdminProfile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<AdminProfile> {
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    int _bottmBarIndex = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.amber,
        currentIndex: _bottmBarIndex,
        fixedColor: kMainColor,
        onTap: (adminValue) async {
          if (adminValue == 2) {
            SharedPreferences preference =
            await SharedPreferences.getInstance();
            preference.clear();
            await _auth.signOut();
            await _auth.googleSignOut();
            Navigator.popAndPushNamed(context, LoginScreen.id);
          }
          if (adminValue == 0) {
            Navigator.popAndPushNamed(context, AdminHome.id);
          }
          setState(() {
            _bottmBarIndex = adminValue;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Orders")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("My Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout), title: Text("Sign out")),
        ],
      ),
    );
  }
}
