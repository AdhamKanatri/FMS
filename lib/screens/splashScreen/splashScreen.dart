import 'package:flutter/material.dart';
import 'package:test_fms/sizeConfig.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String id = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}