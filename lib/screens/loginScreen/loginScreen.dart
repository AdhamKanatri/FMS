import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fms/admin/adminHome.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/provider/adminMode.dart';
import 'package:test_fms/provider/modalhud.dart';
import 'package:test_fms/screens/forgetPassword/forgetPassword.dart';
import 'package:test_fms/screens/signUpScreen.dart';
import 'package:test_fms/sevices/auth.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/user/homeScrren.dart';
import 'package:test_fms/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final _auth = Auth();

  bool isAdmin = false;

  final adminPassword = "admin1234";

  bool keepMeLogin = false;
  bool admin = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double high = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Images/icons/icon8.jpg"), fit: BoxFit.cover),
      ),
      /*decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0xff6a6a68),
              const Color(0xff354753),
              kMainColor,
              const Color(0xff6a6a68),
              kMainColor,
              const Color(0xff6a6a68),

            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),*/
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHub>(context).isLoading,
        child: Form(
          key: widget._globalKey,
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CustomLogo(),
                      SizedBox(
                        height: high * 0.02,
                      ),
                      Text('SIGN IN',style: TextStyle(fontSize: getProportionateScreenWidth(28), color: Colors.white,
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
                        hint: 'Enter your password',
                        icon: Icons.lock_outline,
                        type: TextInputType.visiblePassword,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: keepMeLogin,
                                      onChanged: (value) {
                                        setState(() {
                                          keepMeLogin = value;
                                        });
                                      }),
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: admin,
                                      onChanged: (value) {
                                        if (value == false) {
                                          setState(() {
                                            admin = false;
                                          });
                                          Provider.of<AdminMode>(context,
                                              listen: false)
                                              .changeIsAdmin(false);
                                        } else {
                                          setState(() {
                                            admin = value;
                                          });
                                          Provider.of<AdminMode>(context,
                                              listen: false)
                                              .changeIsAdmin(true);
                                        }
                                      }),
                                ),
                                Text(
                                  'i\'m an admin',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ]),
                      Builder(
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () async {
                              if (keepMeLogin == true) {
                                keepUserLogin();
                              }
                              _validate(context);
                            },
                            color: Colors.amberAccent,
                            child: CustomText(text: 'Login', size: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: high * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Do you ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ForgotPasswordScreen.id);
                            },
                            child: Text(
                              "Forgot password? ",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: high * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don\'t have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, SignUpScreen.id);
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: high * 0.04,
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
                                _validateGoogle();
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
      ),
    ));
  }

  void _validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHub>(context, listen: false);
    modalHud.changeisLoading(true);
    if (widget._globalKey.currentState.validate()) {
      widget._globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            if (admin == true) {
              await _auth.signIn(_email.trim(), _password);
              Navigator.popAndPushNamed(context, AdminHome.id);
              setState(() {
                admin==false;
              });
            }  else{
              try {
                await _auth.signIn(_email.trim(), _password);
                Navigator.popAndPushNamed(context, HomePage.id);
              } on PlatformException catch (ex) {
                modalHud.changeisLoading(false);
                // ignore: deprecated_member_use
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(ex.message)));
              }
            }

          } on PlatformException catch (ex) {
            modalHud.changeisLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(ex.message)));
          } //End catch
        } else {
          modalHud.changeisLoading(false);
          // ignore: deprecated_member_use
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Wrong password")));
        } //End else
      } else {
        try {
          await _auth.signIn(_email.trim(), _password);
          Navigator.popAndPushNamed(context, HomePage.id);
        } on PlatformException catch (ex) {
          modalHud.changeisLoading(false);
          // ignore: deprecated_member_use
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(ex.message)));
        } //End catch
      }
      modalHud.changeisLoading(false);
    }
    ; //if auth
    modalHud.changeisLoading(false);
  }

  void _validateGoogle() async {
    try {
      await _auth.signInWithGoogle();
      Navigator.popAndPushNamed(context, HomePage.id);
    } on PlatformException catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(ex.message)));
    }
  }

  void keepUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLogin, keepMeLogin);
  }
}
