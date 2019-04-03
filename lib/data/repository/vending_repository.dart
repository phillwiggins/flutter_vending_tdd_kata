import 'package:vending_kata/data/contract/vend_contract.dart';
import 'package:vending_kata/data/models/product.dart';
import 'package:vending_kata/data/models/stock.dart';
import 'package:vending_kata/data/models/vending_machine.dart';

///Singleton repository that creates vending machines.
///
///A bit overkill for this app, but showcases the pattern for use cases like network access or
///other IO or slow operations.
class VendingMachineRepository {
  static final VendingMachineRepository _instance =
      VendingMachineRepository._internal();

  factory VendingMachineRepository() {
    return _instance;
  }

  static VendingContract _vendingMachine;

  VendingMachineRepository._internal() {
    final List<Stock> stock = List();
    stock.add(new Stock(Product("Cola", 100), 10));
    stock.add(new Stock(Product("Crisps", 50), 15));
    stock.add(new Stock(Product("Chocolate", 65), 50));
    _vendingMachine = VendingMachine(stock);
  }

  VendingContract getVendingMachine() {
    return _vendingMachine;
  }
}
