import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'file:///C:/Users/4work/AndroidStudioProjects/test_fms/lib/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/widgets.dart';

import 'splashContent.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Finishing, Let’s shop!",
      "image": "Images/themes/splash_1.jpg"
    },
    {
      "text": "We show the easy way to shop and \nhelp construction sector workers. \nJust stay open our app and choose what you want.",
      "image": "Images/themes/splash_3.jpg"
    },
    {
      "text":
      "We help people connect with store around Saudi Arabia \nwith several collection of finishing material. \nJust stay open our app and choose what you want.",
      "image": "Images/themes/splash_2.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(56),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.amberAccent,
                        onPressed: () {
                          Navigator.popAndPushNamed(context, LoginScreen.id);
                        },
                        child: CustomText(text: 'Continue', size: 18),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kMainColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
