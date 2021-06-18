import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';

class Store {
  final Firestore _firestore = Firestore.instance;
  addProduct(Products products) {
    _firestore.collection(kProductCollection).add({
      kProductName: products.pName,
      kProductPrice: products.pPrice,
      kProductDescription: products.pDescription,
      kProductCategory: products.pCategory,
      kProductLocation: products.pImageLocation
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(kProductCollection).snapshots();
  } //9

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  } //9

  Stream<QuerySnapshot> loadOrdersDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .document(documentId)
        .collection(kOrdersDetails)
        .snapshots();
  } //9

  deleteProduct({@required documentID}) {
    _firestore.collection(kProductCollection).document(documentID).delete();
  }

  editProduct({@required data, @required documentID}) {
    _firestore
        .collection(kProductCollection)
        .document(documentID)
        .updateData(data);
  }

  storeOrders({@required data, @required List<Products> products}) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrdersDetails).document().setData({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductLocation: product.pImageLocation,
        kProductCategory: product.pCategory
      });
    }
  }
}
