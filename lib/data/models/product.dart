import 'dart:core';

import 'dart:core';

///
/// A Product
///
class Product {

  /// Construct a product instance
  ///
  /// @param name      product name; must not be empty
  /// @param costInGBPP cost in pence (100th of a GBP pound)
  Product(String name, int costInGBPp) {
    if ("" == name) {
      throw new Exception("name may not be empty");
    }

    if (costInGBPp < 0) {
      throw new Exception("costInUsd must be zero or greater");
    }

    this._name = name;
    this._costInGBPp = costInGBPp;
  }

  String _name;

  /// cost in pence (100th of a GB pound)
  int _costInGBPp;

  String getName() {
    return _name;
  }

  int getCostInGBPp() {
    return _costInGBPp;
  }

  String toString() {
    return "$_name/$_costInGBPp / 100";
  }

  bool equals(Object obj) {
    if (obj is Product) {
      Product p = obj;
      return p.getName() == _name &&
          p.getCostInGBPp() == _costInGBPp;
    }

    return this.equals(obj);
  }

  @override int hashCode() {
    int hash = 17;
    hash = hash * 31 + _name.hashCode;
    hash = hash * 13 + _costInGBPp;
    return hash;
  }
}