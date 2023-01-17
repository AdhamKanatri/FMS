import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/sizeConfig.dart';

import '../../sevices/store.dart';
import '../../user/homeScrren.dart';
import '../user/productInfo.dart';


class SearchField extends StatelessWidget {
  static List<Products> searchList ;
  final _store = Store();
  String itemCode;
  Widget build(BuildContext context) {
      return Container(
        width: SizeConfig.screenWidth * 0.6,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child:StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SearchChoices.single(
                items: searchList.toList().map((i) {
                  return DropdownMenuItem(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductInfo.id,
                              arguments: i);
                        },
                        child: Text(i.pName.toString())),
                    value: i.pName.toString(),
                  );
                }).toList(),
                underline: "",
                hint: "Search",
                searchHint: "Enter product name",
                onChanged: (value) {
                    itemCode = value;
                },
                dialogBox: true,
                keyboardType: TextInputType.visiblePassword,
                isExpanded: true,
                value: itemCode,
              );
            }else{
              return TextField(
                onChanged: (value) => print(value),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "   Search...",
                ),
              );
            }
          }),
        // TextField(
        //   onChanged: (value) => print(value),
        //   decoration: InputDecoration(
        //       contentPadding: EdgeInsets.symmetric(
        //           horizontal: getProportionateScreenWidth(20),
        //           vertical: getProportionateScreenWidth(9)),
        //       border: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //       enabledBorder: InputBorder.none,
        //       hintText: "Search product",
        //       prefixIcon: Icon(Icons.search)),
        // ),
      );

  }
}