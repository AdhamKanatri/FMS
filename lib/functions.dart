import 'models/products.dart';

List<Products> getProductByCategory(
    String kCeramic, List<Products> allProduct) {
  List<Products> products = [];
  try {
    for (var product in allProduct) {
      if (product.pCategory == kCeramic) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}
