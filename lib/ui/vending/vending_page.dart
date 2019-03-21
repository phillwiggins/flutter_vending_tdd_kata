import 'package:flutter/material.dart';
import 'package:vending_kata/data/repository/VendingMachineRepository.dart';
import 'package:vending_kata/domain/bloc/bloc_provider.dart';
import 'package:vending_kata/ui/vending/vending_bloc.dart';

class VendingPage extends StatelessWidget {

  const VendingPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {

    final VendingMachineBloc bloc = BlocProvider.of<VendingMachineBloc>(
        context);
    bloc.init(VendingMachineRepository());

    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getVendingImage(screenWidth)
            ],
          ),
          SizedBox(width: screenWidth / 2, child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _currentCoinSizeText(bloc),
              _displayText(bloc),
              _returnButton(bloc),
              _productOneButton(bloc),
              _productTwoButton(bloc),
              _productThreeButton(bloc),
              _insertCoinsButton(bloc),
              _collectChangeButton(bloc)
            ],))
        ],
          )
      )
    );
    // This trailing comma makes auto-formatting nicer for build methods
  }

  Widget _productOneButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product1,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.purchaseProduct(0),
        );
      },
    );
  }

  Widget _productTwoButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product2,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.purchaseProduct(1),
        );
      },
    );
  }

  Widget _productThreeButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product3,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.purchaseProduct(2),
        );
      },
    );
  }

  Widget _returnButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Return'),
      onPressed: () => bloc.returnCoins(),
    );
  }

  Widget _insertCoinsButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Insert Coins'),
      onPressed: () => bloc.insertCoin(5),
    );
  }

  Widget _collectChangeButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Collect Change'),
      onPressed: () => bloc.collectCoins(),
    );
  }

  Widget _displayText(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.display,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Text(snapshot.data, textScaleFactor: 2,);
      },
    );
  }

  Widget _currentCoinSizeText(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.change,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Text(snapshot.data, textScaleFactor: 1.5);
      },
    );
  }

  Widget _getVendingImage(double imageWidget) {
    return SizedBox(width: imageWidget / 2,
        child: Image.asset(
          'assets/images/vending.jpg',
          fit: BoxFit.fill,
        ));
  }
}
