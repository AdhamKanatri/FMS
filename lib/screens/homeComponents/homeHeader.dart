import 'package:flutter/material.dart';
import 'package:test_fms/screens/user/cartScreen.dart';
import 'package:test_fms/sizeConfig.dart';

import 'iconBtnWithCounter.dart';
import 'searchField.dart';

class HomeHeader extends StatelessWidget {
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
            press: () {},
          ),
        ],
      ),
    );
  }
}