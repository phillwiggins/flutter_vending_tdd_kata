import 'package:flutter_test/flutter_test.dart';
import 'package:vending_kata/data/repository/vending_repository.dart';
import 'package:vending_kata/ui/vending/vending_bloc.dart';

void main() {

  VendingMachineBloc vendingBloc;

  test('when insertCoin is called, updateDisplay is also called', () {
    // Given
    vendingBloc = VendingMachineBloc();
    vendingBloc.init(VendingMachineRepository());

    // When
    vendingBloc.insertCoin(5);
    
    // Then
    expect(vendingBloc.display, emits('5 inserted'));
  });
}