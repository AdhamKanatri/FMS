import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/provider/cartItem.dart';
import 'package:test_fms/screens/user/productInfo.dart';
import 'package:test_fms/sevices/store.dart';
import 'package:test_fms/widgets/customMenu.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Products> products = Provider.of<CartItem>(context).products;
    double high = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    double appBarHigh = AppBar().preferredSize.height;
    double statusBarHigh = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text(
          'My cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: high - (high * 0.08) - appBarHigh - statusBarHigh,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: high * 0.15,
                          width: wid,
                          color: Colors.orange[100],
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: high * 0.075,
                                backgroundImage:
                                    AssetImage(products[index].pImageLocation),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: high * 0.01,
                                            ),
                                            Text(
                                              products[index].pPrice,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Center(
                  child: Container(
                      height: high - (high * 0.08) - appBarHigh - statusBarHigh,
                      child: Text('Your cart is empty')));
            }
          }),
          Builder(
            builder:(context) => ButtonTheme(
              minWidth: wid,
              height: high * 0.08,
              // ignore: deprecated_member_use
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                onPressed: () {
                  showCustomDialog(products, context);
                },
                child: Text(
                  'Order'.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                color: primaryColor,
              ),
            ),
          )
        ]),
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double wid = MediaQuery.of(context).size.width;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, wid - dx, wid - dy),
        items: [
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
            child: Text('Edit'),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
            },
            child: Text('Delete'),
          ),
        ]);
  }

  void showCustomDialog(List<Products> products, context) async {
    var price = getTotalPrice(products);
    var pricetotal = getTotalPrice(products).toStringAsFixed(1);
    var address;
    var category ;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders(
                  data: {kTotalPrice: price, kAddress: address, kProductCategory: category},
                  products: products);
              Scaffold.of(context)
                  // ignore: deprecated_member_use
                  .showSnackBar(SnackBar(content: Text('Success Order')));
              Navigator.pop(context);
            } catch (ex) {
              print(ex.message);
            }
          },
          child: RaisedButton(
              disabledColor: primaryColor,
              child: Text('Confirm',style: TextStyle(color: Colors.white),)),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'Pleas, enter your Number'),
      ),
      title: Text('Total price = RAS $pricetotal'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  double getTotalPrice(List<Products> products) {
    double price = 0;
    for (var product in products) {
      price += product.pQuantity * double.parse(product.pPrice);
    }
    return price;
  }
}
