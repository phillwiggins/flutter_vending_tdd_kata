import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:vending_kata/data/models/product.dart';
import 'package:vending_kata/data/models/vending_machine.dart';
import 'package:vending_kata/data/repository/vending_repository.dart';
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

      updateDisplay('');
    }
  }

  int coinSize = 5;

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

  void changeCoinSize() {}

  Stream<String> getVendingMachineProductDisplay(int productIndex) {}

  void collectCoins() {}

  bool insertCoin(int coinValue) {
    final bool result = vendingMachine.insertCoin(coinSize);
    updateDisplay("$coinValue inserted");
    return result;
  }

  void purchaseProduct(int productIndex) {}

  void returnCoins() {}

  void updateDisplay(String display) {
    setDisplay(display);
  }

  @override
  void dispose() {
    _display.close();
    _change.close();
    _product1.close();
    _product2.close();
    _product3.close();
    _summary.close();
    _change.close();
  }
}
