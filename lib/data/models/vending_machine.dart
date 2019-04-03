import 'package:vending_kata/data/contract/vend_contract.dart';
import 'package:vending_kata/data/models/product.dart';
import 'package:vending_kata/data/models/stock.dart';

/// 5 pence (£0.05)
const int _coinFivePence = 5;

/// 10 pence (£0.10)
const int _coinTenPence = 10;

/// 20 pence (£0.20)
const int _coinTwentyPence = 20;

/// 50 pence (£0.50)
const int _coinFiftyPence = 50;

/// name format key:
/// - static: one of the base values that will show when nothing else is
/// - normal: not static, therefore it will be shown once and will revert to the appropriate 'static'
/// - format: like normal, but also must be run through string.Format() with a float (price/value/GBP)
const String messageInsertCoin = "INSERT COIN";
const String messageExactChangeOnly = "EXACT CHANGE ONLY";
const String messagePrice = "PRICE";
const String messageSoldOut = "SOLD OUT";
const String messageThankYou = "THANK YOU";

/// A Vending machine
class VendingMachine implements VendingContract {
  /// NOTE: Coins are counted internally as integers, and only converted to
  /// decimal GBP on output, to simplify accuracy and increase performance

  /// Construct a machine instance
  ///
  /// @param availableStock available products and their current stock
  VendingMachine(this.availableStock) {
    /// initialize first message, just in case INSERT COINS is not the default based on the available stock provided
    updateAndGetCurrentMessageForDisplay();
  }

  final List<Stock> availableStock;

  /// In-flight/current value of currency provided by the current/last user
  /// for use in purchases
  ///
  /// Starts with no currency in flight—no freebies for the first user!
  int _currencyInGBPp = 0;

  /// Value of coins in the return tray
  int _returnInGBPp = 0;

  /// Track how much change is available in the machine.
  ///
  /// For this demo, assumes the value can be covered by any amount of coins.
  /// In other words, does not track individual coins available as change.
  ///
  /// Starts with £4.00 in change - Can be changed
  int _changeInGBPp = 400;

  String _lastMessage = messageInsertCoin;

  String toString() {
    return
      "£0.00 in flight, "
          "£0.00 in change, and "
          "0 products";
  }

  @override
  bool insertCoin(int GBPp) {
    return false;
  }

  String updateAndGetCurrentMessageForDisplay() {
    return '';
  }

  @override
  int getAcceptedGBPp() {
    return null;
  }

  @override
  int getGBPpInReturn() {
    return null;
  }

  @override
  bool purchaseProduct(int productIndex) {
    return false;
  }

  bool _tryToPurchase(final Stock stock) {
    return false;
  }

  @override
  void returnCoins() {}

  @override
  void collectCoins() {}

  List<Product> getProducts() {
    List<Product> products = List();

    for (final stock in availableStock) {
      products.add(stock.getProduct());
    }

    return products;
  }
}
