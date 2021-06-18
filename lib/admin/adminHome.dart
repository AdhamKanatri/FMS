import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fms/admin/addProduct.dart';
import 'package:test_fms/admin/adminProfile.dart';
import 'package:test_fms/admin/manageProduct.dart';
import 'package:test_fms/admin/orderScreen.dart';
import 'package:test_fms/constants.dart';
import 'file:///C:/Users/4work/AndroidStudioProjects/test_fms/lib/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/sevices/auth.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/widgets.dart';

class AdminHome extends StatefulWidget {
  static String id = "AdminHome";

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _auth = Auth();

  int _bottmBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.amber,
        currentIndex: _bottmBarIndex,
        fixedColor: kMainColor,
        onTap: (adminValue) async{
          if (adminValue==2) {
            SharedPreferences preference= await SharedPreferences.getInstance();
            preference.clear();
            await _auth.signOut();
            Navigator.popAndPushNamed(context, LoginScreen.id);
          }
          if (adminValue == 1) {
            Navigator.popAndPushNamed(context, AdminProfile.id);
          }
          setState(() {
            setState(() {
              _bottmBarIndex = adminValue;
            });
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
      body: CustomPaint(
        size: Size(
            SizeConfig.screenWidth,
            (SizeConfig.screenWidth * 3.675324675324675)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: RPSCustomPainter(),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
              ),
              Icon(Icons.add_business_sharp,color: Colors.amber, size: getProportionateScreenHeight(50),),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.id);
                },
                child: Text('Add product', style: TextStyle(fontSize: 30),),
              ),
              SizedBox(
                height: SizeConfig.screenHeight*0.1,
              ),
              Icon(Icons.edit,color: Colors.amber,size: getProportionateScreenHeight(50),),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, manageProduct.id);
                },
                child: Text('Edit product', style: TextStyle(fontSize: 30),),
              ),
              SizedBox(
                height: SizeConfig.screenHeight*0.1,
              ),
              Icon(Icons.view_agenda_outlined,color: Colors.amber,size: getProportionateScreenHeight(50),),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, OrderScreen.id);
                },
                child: Text('View orders', style: TextStyle(fontSize: 30),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
