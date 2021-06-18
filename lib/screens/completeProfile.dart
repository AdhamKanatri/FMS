import 'package:flutter/material.dart';
import 'package:test_fms/screens/signUpScreen.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/user/homeScrren.dart';
import 'package:test_fms/widgets/widgets.dart';

class CompleteProfile extends StatelessWidget {
  static String id='CompleteProfile';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Images/icons/icon8.jpg"),
                  fit: BoxFit.cover),
            ),
              child: Form(
                key: _globalKey,
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.popAndPushNamed(context, SignUpScreen.id);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                            ]),
                            CustomLogo(),
                            CustomTextFiled(
                              hint: 'Enter your first name',
                              icon: Icons.perm_identity,
                            ),
                            SizedBox(
                              height: gotProportionateScreenHeight(0.02),
                            ),CustomTextFiled(
                              hint: 'Enter your last name',
                              icon: Icons.perm_identity,
                            ),
                            SizedBox(
                              height: gotProportionateScreenHeight(0.02),
                            ),
                            CustomTextFiled(
                              onclick: (value) {
                              },
                              hint: 'Enter your phone number',
                              icon: Icons.phone_android_rounded,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: gotProportionateScreenHeight(0.02),
                            ),
                            CustomTextFiled(
                              onclick: (value) {
                              },
                              hint: 'Enter your address',
                              icon: Icons.location_on,
                            ),
                            SizedBox(
                              height: gotProportionateScreenHeight(0.03),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100),
                              child: Builder(
                                builder: (context) => SizedBox(
                                  width: double.infinity,
                                  height: getProportionateScreenHeight(56),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40)),
                                    onPressed: ()  {
                                      if (_globalKey.currentState.validate()) {
                                      Navigator.popAndPushNamed(context, HomePage.id);
                                    }},
                                    color: Colors.amberAccent,
                                    child: CustomText(text: 'Continue', size: 20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: gotProportionateScreenHeight(0.02),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
