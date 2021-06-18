import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/sevices/store.dart';
import 'package:test_fms/widgets/widgets.dart';

class EditProduct extends StatelessWidget {
  static String id = "EditProduct";
  final Firestore _firestore = Firestore.instance;
  String _name, _price, _description, _category, _imageLocation;
  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double high = MediaQuery.of(context).size.height;
    Products product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: kMainColor,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Images/icons/icon8.jpg"), fit: BoxFit.cover),
          ),
          child: Form(
            key: _globalKey,
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
                      if (value.isEmpty) {
                        _name = product.pName;
                      }
                    },
                    hint: 'Product name ',
                  ),
                  SizedBox(
                    height: high * 0.02,
                  ),
                  CustomTextFiled(
                    onclick: (value) {
                      _price = value;
                      if (value.isEmpty) {
                        _price = product.pPrice;
                      }
                    },
                    hint: 'Product price ',
                  ),
                  SizedBox(
                    height: high * 0.02,
                  ),
                  CustomTextFiled(
                    onclick: (value) {
                      _description = value;
                      if (value.isEmpty) {
                        _description = product.pDescription;
                      }
                    },
                    hint: 'Product description ',
                  ),
                  SizedBox(
                    height: high * 0.02,
                  ),
                  CustomTextFiled(
                    onclick: (value) {
                      _category = value;
                      if (value.isEmpty) {
                        _category = product.pCategory;
                      }
                    },
                    hint: 'Product category ',
                  ),
                  SizedBox(
                    height: high * 0.02,
                  ),
                  CustomTextFiled(
                    onclick: (value) {
                      _imageLocation = value;
                      if (value.isEmpty) {
                        _imageLocation = product.pImageLocation;
                      }
                    },
                    hint: 'Product Location ',
                  ),
                  SizedBox(
                    height: high * 0.02,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          //_globalKey.currentState.reset();
                          print(_firestore
                              .collection(kProductCollection)
                              .snapshots());
                          _globalKey.currentState.save();
                          _store.editProduct(
                              data: ({
                                kProductName: _name,
                                kProductPrice: _price,
                                kProductCategory: _category,
                                kProductDescription: _description,
                                kProductLocation: _imageLocation
                              }),
                              documentID: product.pID);
                        }
                      },
                      child: Text('Edit product'))
                ],
              ),
            ),
          ),
        ));
  }
}
