import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/screens/profile/profileScreen.dart';
import 'package:test_fms/sevices/auth.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/user/homeScrren.dart';

class QuantityCalculotor extends StatefulWidget {
  static String id = 'QuantityCalculoter';
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<QuantityCalculotor> {
  final _auth = Auth();
  var num1, num2;
  double sum = 0, sizeWid = 0.3, sizeLen = 0.3, waste = 0;
  final TextEditingController t1 = TextEditingController(text: "");
  final TextEditingController t2 = TextEditingController(text: "");
  final TextEditingController widText = TextEditingController(text: "");
  final TextEditingController lenText = TextEditingController(text: "");

  void size(double wid, double len, double was) {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      waste = was;
      sizeWid = wid;
      sizeLen = len;
      sum = (((num1 * num2) + (waste * (num1 * num2))) / sizeWid / sizeLen)
          .roundToDouble();
    });
  }

  void doClear() {
    setState(() {
      t1.text = "";
      t2.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    int _bottmBarIndex = 1;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Quantity Calculator",
          style: TextStyle(color: kMainColor),
        )),
        backgroundColor: Colors.orange[50],
        leading: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, HomePage.id);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
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
          if (value == 2) {
            Navigator.popAndPushNamed(context, ProfileScreen.id);
          }
          setState(() {
            _bottmBarIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded), title: Text("Categories")),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_sharp), title: Text("Calculator")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout), title: Text("Log out")),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Quantity you need : $sum piece",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kMainColor),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: "Enter length In meter"),
                    controller: t1,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: "Enter Width In meter"),
                    controller: t2,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Size in cm"),
                        controller: widText,
                      ),
                    ),
                    Text("   X   ",
                        style: TextStyle(
                          fontSize: wid * 0.035,
                        )),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Size in cm"),
                        controller: lenText,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  Center(
                    child: MaterialButton(
                      child: Text(
                        "Calculating main sizes",
                        style: TextStyle(
                            fontSize: wid * 0.035, color: Colors.white),
                      ),
                      color: kMainColor,
                      onPressed: () {
                        setState(() {
                          size(int.parse(widText.text) / 100,
                              int.parse(lenText.text) / 100, 0);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              child: Text(
                                "Without Waste Quantity",
                                style: TextStyle(fontSize: wid * 0.035),
                              ),
                              color: Colors.greenAccent,
                              onPressed: () {
                                setState(() {
                                  size(sizeWid, sizeLen, 0);
                                });
                              },
                            ),
                            MaterialButton(
                              child: Text("30*30 cm",
                                  style: TextStyle(fontSize: wid * 0.03)),
                              color: Colors.amberAccent,
                              onPressed: () {
                                setState(() {
                                  size(0.3, 0.3, waste);
                                });
                              },
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              child: Text(
                                "Waste Quantity 10%",
                                style: TextStyle(fontSize: wid * 0.035),
                              ),
                              color: Colors.greenAccent,
                              onPressed: () {
                                setState(() {
                                  size(sizeWid, sizeLen, 0.10);
                                });
                              },
                            ),
                            MaterialButton(
                              child: Text("30*60 cm",
                                  style: TextStyle(fontSize: wid * 0.03)),
                              color: Colors.amberAccent,
                              onPressed: () {
                                setState(() {
                                  size(0.3, 0.6, waste);
                                });
                              },
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              child: Text(
                                "Waste Quantity 15%",
                                style: TextStyle(fontSize: wid * 0.035),
                              ),
                              color: Colors.greenAccent,
                              onPressed: () {
                                setState(() {
                                  size(sizeWid, sizeLen, 0.15);
                                });
                              },
                            ),
                            MaterialButton(
                              child: Text("60*60 cm",
                                  style: TextStyle(fontSize: wid * 0.03)),
                              color: Colors.amberAccent,
                              onPressed: () {
                                setState(() {
                                  size(0.6, 0.6, waste);
                                });
                              },
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              child: Text(
                                "Waste Quantity 20%",
                                style: TextStyle(fontSize: wid * 0.035),
                              ),
                              color: Colors.greenAccent,
                              onPressed: () {
                                setState(() {
                                  size(sizeWid, sizeLen, 0.20);
                                });
                              },
                            ),
                            MaterialButton(
                              child: Text("120*15 cm",
                                  style: TextStyle(fontSize: wid * 0.03)),
                              color: Colors.amberAccent,
                              onPressed: () {
                                setState(() {
                                  size(1.2, 0.15, waste);
                                });
                              },
                            ),
                          ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          "Clear",
                          style: TextStyle(fontSize: wid * 0.05),
                        ),
                        color: Colors.greenAccent,
                        onPressed: doClear,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
