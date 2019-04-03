import 'package:vending_kata/data/models/product.dart';

///The stock of a product for use in a {@link VendingMachine}
class Stock {
  Stock(this._product, int available) {
    if (available < 0) {
      throw Exception("stock must be zero or greater");
    }
  }

  final Product _product;
  int available;

  Product getProduct() {
    return _product;
  }

  int getAvailable() {
    return available;
  }

  ///Reduces the available stock of this product by one.
  ///
  ///@throws Exception if no product is currently available
  void reduceAvailable() {}

  String toString() { return ''; }
}
