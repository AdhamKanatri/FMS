import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/sevices/store.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    double high = MediaQuery.of(context).size.height;
    String documentId = ModalRoute.of(context).settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdersDetails(documentId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Products> _products = [];
            for (var doc in snapshot.data.documents) {
              _products.add(Products(
                  pName: doc.data[kProductName],
                  pQuantity: doc.data[kProductQuantity],
                  pPrice: doc.data[kProductPrice],
                  pCategory: doc.data[kProductCategory]));
            }
            return Scaffold(
              body: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Images/icons/icon8.jpg"), fit: BoxFit.cover),
                ),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Container(
                        height: high * 0.2,
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Product name: ${_products[index].pName}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: high * 0.02,
                              ),
                              Text(
                                'Quantity: ${_products[index].pQuantity}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: high * 0.02,
                              ),
                              Text(
                                'Category: ${_products[index].pCategory}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: _products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ButtonTheme(
                          buttonColor: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text('Confirm order',
                                style: TextStyle(
                                    fontSize: 20)),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        ButtonTheme(
                          buttonColor: Colors.redAccent,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Delete order',
                              style: TextStyle(
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              )),
            );
          } else {
            return Center(
              child: Text(
                'Loading order details',
                style: TextStyle(color: Colors.deepOrangeAccent),
              ),
            );
          }
          return Container();
        });
  }
}
