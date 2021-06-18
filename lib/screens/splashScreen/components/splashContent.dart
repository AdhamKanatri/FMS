import 'package:flutter/material.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/widgets.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        CustomText(text: 'Finishing', size: 36,),
        SizedBox(height: 10,),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}