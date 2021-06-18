import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/functions.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/screens/user/productInfo.dart';
import 'package:test_fms/sevices/store.dart';

class ProductType extends StatelessWidget {
  static String id='ProductType';
  final _store = Store();
  List<Products> _products = [];
  @override
  Widget build(BuildContext context) {
    String type = ModalRoute.of(context).settings.arguments;
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[50],
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(
                '$type',
                style: TextStyle(color: Colors.black),
              ),]
            ),
          ),
          body: ceramicViewer());

  }

  Widget ceramicViewer() {
    return StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            String type = ModalRoute.of(context).settings.arguments;
            if (snapshot.hasData) {
              List<Products> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Products(
                  pID: doc.documentID,
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pDescription: data[kProductDescription],
                  pCategory: data[kProductCategory],
                  pImageLocation: data[kProductLocation],
                ));
              }
              _products = [...products];
              products.clear();
              products = getProductByCategory(type, _products);
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.9),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductInfo.id,
                          arguments: products[index]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage(products[index].pImageLocation))),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      products[index].pName,
                                      style:
                                          TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'SAR ${products[index].pPrice}',
                                      style:
                                          TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: products.length,
              ); //return
            } else {
              return Center(
                  child: Text(
                    'Loading data ...',
                    style: TextStyle(fontSize: 15),
                  ));
            }
          });
  }
}
