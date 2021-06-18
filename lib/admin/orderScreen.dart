import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/admin/OrderDetails.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/order.dart';
import 'package:test_fms/sevices/store.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    double high = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('There are no order'),
            );
          } else {
            List<Order> order = [];
            for (var doc in snapshot.data.documents) {
              order.add(Order(
                  address: kAddress,
                  totalPrice: doc.data[kTotalPrice],
                  documentId: doc.documentID,
                  category: doc.data[kProductCategory]));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: order[index].documentId);
                  },
                  child: Container(
                    height: high * 0.2,
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Price = \$${order[index].totalPrice}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: high * 0.02,
                          ),
                          Text(
                            'Address is ${order[index].address}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: high * 0.02,
                          ),
                          Text(
                            'Category: ${order[index].category}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: order.length,
            );
          }
        },
      ),
    );
  }
}
