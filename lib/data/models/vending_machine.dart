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
  /// Starts with $4.00 in change (since the kata requirements did not specify
  /// the amount)
  int _changeInGBPp = 400;

  String _lastMessage = messageInsertCoin;

  String toString() {
    return "£$_currencyInGBPp in flight, £$_changeInGBPp in change, and %$availableStock products";
  }

  @override
  bool insertCoin(int GBPp) {
    /// check for valid coin
    switch (GBPp) {
      case _coinFivePence:
      case _coinTenPence:
      case _coinTwentyPence:
      case _coinFiftyPence:
        {
          // valid
          this._currencyInGBPp += GBPp;
          this._lastMessage =
              "£ ${_currencyInGBPp / 100}";
          return true;
        }
      default:
        // invalid coins: pennies, drachmas, kronors, pfennigs, etc.
        _currencyInGBPp += GBPp;
        return false;
    }
  }

  String updateAndGetCurrentMessageForDisplay() {
    String msgToDeliver = _lastMessage;

    /// now that any temporary message is saved for deliver, reset the next call to the
    /// current state of the machine
    if (_currencyInGBPp == 0) {
      // no money inserted yet
      _lastMessage = messageInsertCoin;

      /// REQUIREMENT: When the machine is not able to make change with the money in the machine for any of the items that it sells, it will display EXACT CHANGE ONLY instead of INSERT COIN.
      /// Personal note: The provided description is a bit trivialized. The real logic needs to check change coins available and the matrix of what possible combinations can provide what values, the minimum and maximum amount of value for an accepted coin, whether or not accepted coins may also be used in change (for example, paper dollars can't be returned as change, but other coins should be able to funnel through the system as change if too many are provided), the price of all items, and figure out what the limits of all those items combined are; which gets complicated;
      /// therefore, sticking with the naive algorithm of is there enough change value to at least match the price of the most expensive item
      for (final Stock stock in availableStock) {
        if (stock.getProduct().getCostInGBPp() > _changeInGBPp) {
          _lastMessage = messageExactChangeOnly;
          break;
        }
      }
    } else {
      _lastMessage = "${_currencyInGBPp / 100}";
    }

    return msgToDeliver;
  }

  @override
  int getAcceptedGBPp() {
    return _currencyInGBPp;
  }

  @override
  int getGBPpInReturn() {
    return _returnInGBPp;
  }

  @override
  bool purchaseProduct(int productIndex) {
    return productIndex < availableStock.length &&
        _tryToPurchase(availableStock[productIndex]);
  }

  bool _tryToPurchase(final Stock stock) {
    /// check stock
    if (stock.getAvailable() == 0) {
      _lastMessage = messageSoldOut;
      return false;
    }

    /// check available currency compared to price
    Product product = stock.getProduct();

    if (_currencyInGBPp - product.getCostInGBPp() < 0) {
      /// not enough money
      _lastMessage = "$messagePrice £${product.getCostInGBPp() / 100}";
      return false;
    }

    /// passed tests; buy! buy! buy!
    /// reduce stock
    stock.reduceAvailable();

    /// take cost from active currency...
    _currencyInGBPp -= product.getCostInGBPp();

    /// ...and add it to the stock of change available
    /// TODO: until exact coin change is implemented (as opposed to just value processing), the following does not make sense since the machine would never run out of change
    /// _changeInGBPp += product.getCostInGBPp();
    /// so instead pull change value out of change and do NOT recycle in provided coins back into the change purse
    _changeInGBPp -= _currencyInGBPp;

    /// then zero out currency, returning to the user anything left;
    _returnInGBPp += _currencyInGBPp;
    _currencyInGBPp = 0;

    _lastMessage = messageThankYou;

    /// while the user enjoys their purchase, report success
    return true;
  }

  @override
  void returnCoins() {
    /// these two statements should be transactional (instead of the current atomic but separate) to ensure thread-safety, but this isn't banking software—it is a demo for crying out loud
    _returnInGBPp += _currencyInGBPp;
    _currencyInGBPp = 0;

    /// reset state of display
    updateAndGetCurrentMessageForDisplay();
  }

  @override
  void collectCoins() {
    _returnInGBPp = 0;
  }

  List<Product> getProducts() {
    List<Product> products = List();

    for (final stock in availableStock) {
      products.add(stock.getProduct());
    }

    return products;
  }
}
