import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/widgets.dart';
import 'package:test_fms/sevices/store.dart';

class AddProduct extends StatelessWidget {
  static String id = "AddProduct";
  String _name, _price, _description, _category, _imageLocation;
  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double high = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Images/icons/icon8.jpg"), fit: BoxFit.cover),
          ),
          child: Form(
            key: _globalKey,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: high * 0.2,
                        ),
                        CustomTextFiled(
                          onclick: (value) {
                            _name = value;
                          },
                          hint: 'Product name',
                        ),
                        SizedBox(
                          height: high * 0.02,
                        ),
                        CustomTextFiled(
                          onclick: (value) {
                            _price = value;
                          },
                          hint: 'Product price',
                        ),
                        SizedBox(
                          height: high * 0.02,
                        ),
                        CustomTextFiled(
                          onclick: (value) {
                            _description = value;
                          },
                          hint: 'Product description',
                        ),
                        SizedBox(
                          height: high * 0.02,
                        ),
                        CustomTextFiled(
                          onclick: (value) {
                            _category = value;
                          },
                          hint: 'Product category',
                        ),
                        SizedBox(
                          height: high * 0.02,
                        ),
                        CustomTextFiled(
                          onclick: (value) {
                            _imageLocation = value;
                          },
                          hint: 'Product Location',
                        ),
                        SizedBox(
                          height: high * 0.02,
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                            onPressed: () {
                              if (_globalKey.currentState.validate()) {
                                _globalKey.currentState.save();
                                _store.addProduct(Products(
                                    pName: _name,
                                    pPrice: _price,
                                    pCategory: _category,
                                    pDescription: _description,
                                    pImageLocation: _imageLocation));
                              }
                            },
                            child: Text('Add product',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(30))))
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
