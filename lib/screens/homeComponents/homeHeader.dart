import 'package:flutter/material.dart';
import 'package:test_fms/screens/user/cartScreen.dart';
import 'package:test_fms/sizeConfig.dart';

import 'iconBtnWithCounter.dart';
import 'searchField.dart';

class HomeHeader extends StatelessWidget {
  static List searchList;
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            icon: Icons.shopping_cart,
            press: () => Navigator.pushNamed(context, CartScreen.id),
          ),
          IconBtnWithCounter(
            icon: Icons.notifications,
            numOfitem: 0,
            press: () => showCustomDialog(context),
          ),
        ],
      ),
    );
  }
  void showCustomDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 12),
                  Text(
                    'No notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
  );
}