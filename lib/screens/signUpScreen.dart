import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:test_fms/provider/modalhud.dart';
import 'package:test_fms/screens/completeProfile.dart';
//import 'file:///C:/Users/4work/AndroidStudioProjects/test_fms/lib/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/sevices/auth.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/user/homeScrren.dart';
import 'package:test_fms/widgets/widgets.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  LoginScreen widget = LoginScreen();
  //TextEditingController _email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double high = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Images/icons/icon8.jpg"),
                  fit: BoxFit.cover),
            ),
            child: ModalProgressHUD(
              inAsyncCall: Provider.of<ModalHub>(context).isLoading,
              child: Form(
                key: _globalKey,
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, LoginScreen.id);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                            ]),
                            CustomLogo(),
                            /*CustomTextFiled(
                              hint: 'Enter your name',
                              icon: Icons.perm_identity,
                            ),*/
                            SizedBox(
                              height: high * 0.02,
                            ),
                            Text('SIGN UP',style: TextStyle(fontSize: getProportionateScreenWidth(28), color: Colors.white,
                                decoration: TextDecoration.underline, decorationColor: Colors.orange),),
                            SizedBox(
                              height: high * 0.02,
                            ),
                            CustomTextFiled(
                              onclick: (value) {
                                _email = value;
                              },
                              hint: 'Enter your email',
                              icon: Icons.email,
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: high * 0.02,
                            ),
                            CustomTextFiled(
                              onclick: (value) {
                                _password = value;
                              },
                              password: password,
                              hint: 'Enter your password',
                              icon: Icons.lock_outline,
                              type: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: high * 0.02,
                            ),
                            TextFormField(
                              controller: _confirmPass,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Pleas, confirm your password';
                                }else if (value != password.text) {
                                  return 'Pleas, confirm password';
                                }
                                return null;
                              },
                              obscureText: true,
                              cursorColor: kMainColor,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: 'confirm your password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: kMainColor,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(color: Colors.red)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(color: Colors.red)),
                                  errorStyle:
                                  TextStyle(color: Colors.redAccent[100], fontWeight: FontWeight.w700,)),
                            ),
                            SizedBox(
                              height: high * 0.03,
                            ),
                            Builder(
                              builder: (context) => SizedBox(
                                width: double.infinity,
                                height: getProportionateScreenHeight(56),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  onPressed: () async {
                                    final modalHud =
                                        Provider.of<ModalHub>(context, listen: false);
                                    modalHud.changeisLoading(true);
                                    if (_globalKey.currentState.validate()) {
                                      try {
                                        _globalKey.currentState.save();
                                        final authResult = await _auth.signUp(
                                            _email.trim(), _password);
                                        modalHud.changeisLoading(false);
                                        Navigator.pushNamed(
                                            context, CompleteProfile.id);
                                        print(authResult.user.uid);
                                      } on PlatformException catch (ex) {
                                        modalHud.changeisLoading(false);
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(content: Text(ex.message)));
                                      } //End catch
                                      modalHud.changeisLoading(false);
                                    }
                                    ; //if auth
                                    modalHud.changeisLoading(false);
                                  },
                                  color: Colors.amberAccent,
                                  child: CustomText(text: 'Continue', size: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: high * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, LoginScreen.id);
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: high * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white)),
                                Text(
                                  '  OR SIGN IN WITH  ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Expanded(child: Divider(color: Colors.white))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButtonSocial(
                                    text: 'Facebook',
                                    onPress: () {},
                                    imageName: 'Images/icons/facebook.png',
                                  ),
                                  CustomButtonSocial(
                                    text: 'Google',
                                    onPress: () {
                                      _validateGoogle(context);
                                    },
                                    imageName: 'Images/icons/google.png',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
  void _validateGoogle(BuildContext context) async {
    try {
      await _auth.signInWithGoogle();
      Navigator.popAndPushNamed(context, HomePage.id);
    } on PlatformException catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(ex.message)));
    }
  }
}
/*SplashScreenView(
      home: SecondScreen(),
      duration: 5000,
      imageSize: 100,
      imageSrc: "logo.png",
      text: "Colorize Text",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
*/
