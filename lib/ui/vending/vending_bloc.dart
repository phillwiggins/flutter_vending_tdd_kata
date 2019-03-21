import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:vending_kata/data/models/product.dart';
import 'package:vending_kata/data/models/vending_machine.dart';
import 'package:vending_kata/data/repository/VendingMachineRepository.dart';
import 'package:vending_kata/domain/bloc/bloc_base.dart';

class VendingMachineBloc implements BlocBase {

  void init(VendingMachineRepository vendingMachineRepository) {
    if (this.vendingMachine == null) {
      this.vendingMachine = vendingMachineRepository.getVendingMachine();

      // initialize data
      List<Product> products = vendingMachine.getProducts();
      _product1.sink.add(products[0].getName());
      _product2.sink.add(products[1].getName());
      _product3.sink.add(products[2].getName());

      updateDisplay();
    }
  }

  final BehaviorSubject<String> _display =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _summary =
  BehaviorSubject<String>();
  final BehaviorSubject<String> _change =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product1 =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product2 =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product3 =
      BehaviorSubject<String>();

  Stream<String> get display => _display.stream;

  Stream<String> get change => _change.stream;

  Stream<String> get summary => _summary.stream;

  Stream<String> get product1 => _product1.stream;

  Stream<String> get product2 => _product2.stream;

  Stream<String> get product3 => _product3.stream;

  void setDisplay(String message) => _display.add(message);

  void setChange(String message) => _change.add(message);

  void setSummary(String message) => _summary.add(message);

  VendingMachine vendingMachine;

  Stream<String> getVendingMachineProductDisplay(int productIndex) {
    switch (productIndex) {
      case 0:
        return product1;
      case 1:
        return product2;
      case 2:
        return product3;
      default:
        throw new Exception(
            "Only 3 products available but item ${productIndex - 1} was requested");
    }
  }

  void collectCoins() {
    if (this.vendingMachine == null) {
      throw new Exception(
          "you must call init() before calling any other methods in this view model");
    }

    vendingMachine.collectCoins();
    updateDisplay();
  }

  bool insertCoin(int coinValue) {
    if (vendingMachine == null) {
      throw new Exception(
          "you must call init() before calling any other methods in this view model");
    }

    final bool result = vendingMachine.insertCoin(coinValue);
    updateDisplay();
    return result;
  }

  void purchaseProduct(int productIndex) {
    if (vendingMachine == null) {
      throw Exception(
          "you must call init() before calling any other methods in this view model");
    }

    vendingMachine.purchaseProduct(productIndex);
    updateDisplay();
  }

  void returnCoins() {
    if (vendingMachine == null) {
      throw Exception(
          "you must call init() before calling any other methods in this view model");
    }

    this.vendingMachine.returnCoins();
    updateDisplay();
  }

  void updateDisplay() {
    if (vendingMachine == null) {
      throw Exception(
          "you must call init() before calling any other methods in this view model");
    }

    setDisplay(vendingMachine.updateAndGetCurrentMessageForDisplay());
    setChange("Collect ${vendingMachine.getGBPpInReturn()}");
    setSummary(vendingMachine.toString());
  }

  @override
  void dispose() {
    _display.close();
    _change.close();
    _product1.close();
    _product2.close();
    _product3.close();
    _summary.close();
  }
}
