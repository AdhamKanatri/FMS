import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_fms/sizeConfig.dart';

const kMainColor = Color(0xFF515151);
const kProductName = 'productName';
const kProductPrice = 'productPrice';
const kProductDescription = 'productDescription';
const kProductCategory = 'productCategory';
const kProductLocation = 'productLocation';
const kProductCollection = 'Products';
const kCeramic = 'Ceramic';
const kParquet = 'Parquet';
const kMarble = 'Marble';
const kStone = 'Stone';
const kOrders = 'Orders';
const kOrdersDetails = 'OrdersDetails';
const kTotalPrice = 'TotalPrice';
const kAddress = 'Address';
const kProductQuantity = 'Quantity';
const kKeepMeLogin = 'KeepMeLogin';
const kLinearGradient =
    LinearGradient(begin: Alignment.bottomRight, colors: <Color>[
  Color(0xff9BADB8),
  Color(0xff394A53),
  Color(0xff9BADB8),
  Color(0xff394A53),
]);
const primaryColor = Color.fromRGBO(0, 197, 105, 1);

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
