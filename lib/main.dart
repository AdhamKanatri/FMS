import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:test_fms/admin/addProduct.dart';
import 'package:test_fms/admin/adminHome.dart';
import 'package:test_fms/admin/adminProfile.dart';
import 'package:test_fms/admin/manageProduct.dart';
import 'package:test_fms/admin/orderScreen.dart';
import 'package:test_fms/models/ProductType.dart';
import 'package:test_fms/provider/adminMode.dart';
import 'package:test_fms/provider/modalhud.dart';
import 'package:test_fms/screens/completeProfile.dart';
import 'package:test_fms/screens/forgetPassword/forgetPassword.dart';
import 'package:test_fms/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/screens/profile/profileScreen.dart';
import 'package:test_fms/screens/quantityCalculater.dart';
import 'package:test_fms/screens/signUpScreen.dart';
import 'package:test_fms/screens/splashScreen/IntroScreen.dart';
import 'package:test_fms/screens/splashScreen/splashScreen.dart';
import 'package:test_fms/user/homeScrren.dart';
import 'admin/OrderDetails.dart';
import 'admin/editProduct.dart';
import 'constants.dart';
import 'provider/cartItem.dart';
import 'screens/signUpScreen.dart';
import 'screens/user/cartScreen.dart';
import 'screens/user/productInfo.dart';

main() => runApp(MyApp());
//
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: kMainColor,
                body: Center(
                    child: Text(
                  'Loading....',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                )),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kKeepMeLogin) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModalHub>(
                    create: (context) => ModalHub()),
                ChangeNotifierProvider<AdminMode>(
                    create: (context) => AdminMode()),
                ChangeNotifierProvider<CartItem>(
                    create: (context) => CartItem()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? IntroScreen.id : SplashScreen.id,
                routes: {
                  IntroScreen.id: (context) => IntroScreen(),
                  QuantityCalculotor.id: (context) => QuantityCalculotor(),
                  ProductType.id: (context) => ProductType(),
                  CompleteProfile.id: (context) => CompleteProfile(),
                  ProfileScreen.id: (context) => ProfileScreen(),
                  AdminProfile.id: (context) => AdminProfile(),
                  ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
                  SplashScreen.id: (context) => SplashScreen(),
                  ProductInfo.id: (context) => ProductInfo(),
                  AdminHome.id: (context) => AdminHome(),
                  HomePage.id: (context) => HomePage(),
                  LoginScreen.id: (context) => LoginScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  AddProduct.id: (context) => AddProduct(),
                  manageProduct.id: (context) => manageProduct(),
                  EditProduct.id: (context) => EditProduct(),
                  CartScreen.id: (context) => CartScreen(),
                  OrderScreen.id: (context) => OrderScreen(),
                  OrderDetails.id: (context) => OrderDetails(),
                },
              ),
            );
          }
        });
  }
}
