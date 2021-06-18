import 'package:flutter/material.dart';
import 'package:test_fms/user/homeScrren.dart';
import 'package:test_fms/widgets/widgets.dart';

class IntroScreen extends StatefulWidget {
  static String id='IntroScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<IntroScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 3);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
            (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/icons/icon8.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: CustomLogo(),
        ),
      ),
    );
  }
}