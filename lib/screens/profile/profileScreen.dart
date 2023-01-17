import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/screens/profile/body.dart';
import 'package:test_fms/screens/quantityCalculater.dart';
import 'package:test_fms/sevices/auth.dart';
import 'package:test_fms/user/homeScrren.dart';


class ProfileScreen extends StatefulWidget {
  static String id = "ProfileScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    int _bottmBarIndex = 2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.orange[50],
      ),
      body: Body(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.amber,
          currentIndex: _bottmBarIndex,
          fixedColor: kMainColor,
          onTap: (value) async {
            if (value == 3) {
              SharedPreferences preference =
              await SharedPreferences.getInstance();
              preference.clear();
              await _auth.signOut();
              await _auth.googleSignOut();
              Navigator.popAndPushNamed(context, LoginScreen.id);
            }
            if (value == 0) {
              Navigator.popAndPushNamed(context, HomePage.id);
            }
            if (value == 1) {
              Navigator.popAndPushNamed(context, QuantityCalculotor.id);
            }
            setState(() {
              _bottmBarIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate_sharp), label: "Calculator"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout), label: "Log out"),
          ],
        ),
    );
  }
}
