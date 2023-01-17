import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/provider/cartItem.dart';
import 'package:test_fms/screens/user/cartScreen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/widgets.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  CarouselController buttonCarouselController = CarouselController();
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  double totalPrice=1;
  String total= '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Products product = ModalRoute.of(context).settings.arguments;
    total=product.pPrice;
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        child: Image.asset(
                          product.pImageLocation,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            CustomTextPro(
                              text: product.pName,
                              fontSize: 26,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  width: MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.grey,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextPro(
                                        text: 'Size',
                                      ),
                                      CustomTextPro(
                                        text: "60 x 60",
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  width: MediaQuery.of(context).size.width * .44,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.grey,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextPro(
                                        text: 'Color',
                                      ),
                                      Container(
                                        width: 30,
                                        height: 20,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(20),
                                          color: kMainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            CustomTextPro(
                            text: 'Country of origin: ',
                            fontSize: getProportionateScreenWidth(20),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.01,
                            ),
                            CustomTextPro(
                            text: product.pDescription,
                            fontSize: getProportionateScreenWidth(18),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    child: GestureDetector(
                                      child: SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Icon(Icons.add),
                                      ),
                                      onTap: (){
                                        add();
                                        setState(() {
                                          totalPrice=_quantity*double.parse((product.pPrice));
                                          total=totalPrice.toStringAsFixed(1);
                                          totalPrice=double.parse((total));
                                        });},
                                    ),
                                    color: Colors.lightGreen,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.01,
                                ),
                                Text(
                                  _quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.01,
                                ),
                                ClipOval(
                                  child: Material(
                                    child: GestureDetector(
                                      child: SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Icon(Icons.remove),
                                      ),
                                      onTap: (){
                                        subtract();
                                        setState(() {
                                          totalPrice=_quantity*double.parse(product.pPrice);
                                          total=totalPrice.toStringAsFixed(1);
                                          totalPrice=double.parse((total));

                                        });
                                        },
                                    ),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 10,bottom: 30,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      CustomTextPro(
                                        text: "PRICE ",
                                        fontSize: 22,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.screenHeight * 0.01,
                                      ),
                                      priceView()
                                    ],
                                  ),
                                  Builder(
                                    builder:(context) => CustomButton(
                                      onPress: () {
                                        addToCart(context, product);},
                                      text: 'Add',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /*Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: [1].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/icon8.jpg"),),
                        ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: high*0.05,),
          Padding(
            padding: EdgeInsets.fromLTRB(23, 30, 20, 0),
            child: Container(
              height: high * 0.10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.add_shopping_cart)),
                ],
              ),
            ),
          ),
          // ignore: deprecated_member_use
          Positioned(
            bottom: 0,
            child: Column(children: <Widget>[
              Opacity(
                child: Container(
                  color: Colors.white,
                  width: wid,
                  height: high * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.pName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: high * 0.01,
                        ),
                        Text(
                          product.pDescription,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: high * 0.01,
                        ),
                        Text(
                          'SAR ${product.pPrice}',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipOval(
                              child: Material(
                                child: GestureDetector(
                                  child: SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: Icon(Icons.add),
                                  ),
                                  onTap: add,
                                ),
                                color: Colors.lightGreen,
                              ),
                            ),
                            SizedBox(
                              width: wid * 0.01,
                            ),
                            Text(
                              _quantity.toString(),
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: wid * 0.01,
                            ),
                            ClipOval(
                              child: Material(
                                child: GestureDetector(
                                  child: SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: Icon(Icons.remove),
                                  ),
                                  onTap: subtract,
                                ),
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                opacity: 0.5,
              ),
              ButtonTheme(
                minWidth: wid,
                height: high * 0.1,
                child: Builder(
                  // ignore: deprecated_member_use
                  builder: (context) => MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                    color: kMainColor,
                    onPressed: () {
                      addToCart(context, product);
                    },
                    child: Text(
                      'Add to cart'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );*/
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart == product) {
        exist = true;
      }
    }
    if (exist) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${product.pName} was add to cart before'),
      ));
    } else {
      cartItem.addProduct(product);
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${product.pName} added to cart'),
      ));
    }
  }
  Widget priceView(){
    if (totalPrice == 1) {
      return CustomTextPro(
        text: ' RAS $total',
        color: primaryColor,
        fontSize: 18,
      );
    }  else {
      return CustomTextPro(
        text: ' RAS $totalPrice',
        color: primaryColor,
        fontSize: 18,
      );
    }
  }
}
