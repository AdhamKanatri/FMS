import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fms/constants.dart';
import 'package:test_fms/models/products.dart';
import 'package:test_fms/screens/homeComponents/categories.dart';
import 'package:test_fms/screens/homeComponents/discountBanner..dart';
import 'package:test_fms/screens/homeComponents/homeHeader.dart';
import 'package:test_fms/screens/homeComponents/sectionTitle.dart';
import 'package:test_fms/screens/homeComponents/specialOffers.dart';
import 'package:test_fms/screens/profile/profileScreen.dart';
import 'package:test_fms/screens/quantityCalculater.dart';
import 'file:///C:/Users/4work/AndroidStudioProjects/test_fms/lib/screens/loginScreen/loginScreen.dart';
import 'package:test_fms/screens/user/cartScreen.dart';
import 'package:test_fms/screens/user/productInfo.dart';
import 'package:test_fms/sevices/auth.dart';
import 'package:test_fms/sevices/store.dart';
import 'package:test_fms/sizeConfig.dart';
import 'package:test_fms/widgets/productViewer.dart';

import '../functions.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  final _auth = Auth();
  final _store = Store();
  FirebaseUser _logeedUser;
  int _tabBarIndex = 0;
  List<Products> _products = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int _bottmBarIndex = 0;
    // TODO: implement build
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.amber,
              currentIndex: _bottmBarIndex,
              fixedColor: kMainColor,
              onTap: (value) async {
                if (value == 3) {
                  SharedPreferences preference =
                      await SharedPreferences.getInstance();
                  preference.clear();
                  await _auth.signOut();
                  await _auth.googleSignOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                if (value == 1) {
                  Navigator.popAndPushNamed(context, QuantityCalculotor.id);
                }
                if (value == 2) {
                  Navigator.popAndPushNamed(context, ProfileScreen.id);
                }
                setState(() {
                  _bottmBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.category_rounded), title: Text("Categories")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calculate_sharp), title: Text("Calculator")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text("Profile")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.logout), title: Text("Log out")),
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: getProportionateScreenWidth(10),),
                    HomeHeader(),
                    DiscountBanner(),
                    Categories(),
                    SpecialOffers(),
                  ]),
                ),
            ),


          ))],
    );
  }

  @override
  void initState() {
    getCurrenUser();
  }

  getCurrenUser() async {
    _logeedUser = await _auth.getUser();
  }

  Widget ceramicViewer() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
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
            products = getProductByCategory(kCeramic, _products);
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
                      Column(
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                            child: SectionTitle(
                              title: "Special for you",
                              press: () {},
                            ),
                          ),
                          SizedBox(height: getProportionateScreenWidth(20)),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SpecialOfferCard(
                                  image: products[index].pImageLocation,
                                  category: products[index].pCategory,
                                  numOfBrands: 18,
                                  press: () {},
                                ),
                                SpecialOfferCard(
                                  image: products[index].pImageLocation,
                                  category: products[index].pCategory,
                                  numOfBrands: 24,
                                  press: () {},
                                ),
                                SizedBox(width: getProportionateScreenWidth(20)),
                              ],
                            ),
                          ),
                        ],

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
