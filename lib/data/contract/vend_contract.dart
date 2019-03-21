import 'package:vending_kata/data/models/product.dart';

/// Service for core vend functionality
abstract class VendingContract {
  ///Accepts a coin (based on its value) and adds to current in-process cash
  /// if valid
  ///
  /// @param GBPp GBP pence amount (100th of a GB pound) of the coin inserted
  /// @return true if the coin was accepted; false if the coin was rejected
  /// and added to the coins-in-return
  ///
  bool insertCoin(int GBPp);

  /// Updates the current display message based on the state of the vending
  /// machine and returns what that should show to the user
  ///
  /// Non-deterministic: display may change from one call to the next
  /// depending on the state of the machine
  ///
  /// @return the message to display to the user, will be listed as USD if
  /// any value is shown
  String updateAndGetCurrentMessageForDisplay();

  /// Gets the value of coins in the return (either that were rejected during
  /// insert, or user requested a return
  ///
  /// @return the value of coins in the return, as cents (100th of a USD)
  int getAcceptedGBPp();

  /// Gets the value of coins in the return (either that were rejected during
  /// insert, or user requested a return
  ///
  /// @return the value of coins in the return, as cents (100th of a USD)
  int getGBPpInReturn();

  /// Purchases the requested product.
  ///
  /// If enough currency and product is available, will deliver to the user
  /// and deduct the value from the in-process cash.
  ///
  /// If the product may not be purchased at this time, will return false.
  ///
  /// Either success or failure will update the display appropriately; make
  /// sure to check and display to the user
  ///
  /// @param productIndex the index of the requested product
  /// @return true if the product was purchased and delivered to the user;
  /// false if invalid for any reason
  bool purchaseProduct(int productIndex);

  /// User may request coins to return all available currency in the machine
  /// not used for a purchase yet; available coins go to the return, aka
  /// {@link #getGBPpInReturn()}
  void returnCoins();

  /// Simulate user collecting the coins in the return.
  ///
  /// Effectively zeros out anything in {@link #getGBPpInReturn()}.
  void collectCoins();

  /// List of all products in the machine
  ///
  /// @return list of products
  List<Product> getProducts();
}
