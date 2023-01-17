import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/widgets/customMenu.dart';
import 'package:test_fms/widgets/widgets.dart';
import 'package:test_fms/sevices/store.dart';

import 'editProduct.dart';

class manageProduct extends StatefulWidget {
  static String id = "manageProduct";

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<manageProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("Images/icons/icon8.jpg"), fit: BoxFit.cover),
    ),
    child: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, AsyncSnapshot snapshot) {
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
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.9),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTapUp: (details) async{
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      await showMenu(
                          context: context,
                          position:
                              RelativeRect.fromLTRB(dx, dy, wid - dx, wid - dy),
                          items: [
                            MyPopupMenuItem(
                              onClick: () {
                                Navigator.pushNamed(context, EditProduct.id,
                                    arguments: products[index]);
                              },
                              child: Text('Edit'),
                            ),
                            MyPopupMenuItem(
                              onClick: () {
                                _store.deleteProduct(
                                    documentID: products[index].pID);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                          ]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    products[index].pImageLocation))),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'SAR ${products[index].pPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
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
          }),
    ));
  }
}


