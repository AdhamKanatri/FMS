import 'package:flutter/material.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/screens/user/productInfo.dart';
import '../functions.dart';

Widget productViewer(String pCategory, List<Products> allProduct) {
  List<Products> products = [];
  products = getProductByCategory(pCategory, allProduct);
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
                    image: AssetImage(products[index].pImageLocation))),
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
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'SAR ${products[index].pPrice}',
                          style: TextStyle(fontWeight: FontWeight.w700),
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
  );
}
