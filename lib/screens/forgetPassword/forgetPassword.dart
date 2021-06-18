import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/components/defaultButton.dart';
import 'package:test_fms/components/formError.dart';
import 'package:test_fms/components/noAccountText.dart';
import 'package:test_fms/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String id = "ForgotPasswordScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, LoginScreen.id);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black87,
                              size: 35,
                            )),
                        CustomText(text: 'Forget Password', size: 28),
                        Text('         ')
                      ]),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Please enter your email and we will send \n you a link to return to your account",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  ForgotPassForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (input) => isEmail(input) ? null : "Pleas, enter correct email address.",
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.email,
                  color: kMainColor,
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(56),
            // ignore: deprecated_member_use
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Pleas, check your email')));
                }
              },
              color: Colors.amberAccent,
              child: CustomText(text: 'Continue', size: 18),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}