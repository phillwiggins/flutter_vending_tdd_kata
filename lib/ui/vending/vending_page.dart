import 'package:flutter/material.dart';
import 'package:vending_kata/domain/bloc/bloc_provider.dart';
import 'package:vending_kata/ui/vending/vending_bloc.dart';

class VendingPage extends StatelessWidget {

  VendingPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {

    final VendingMachineBloc bloc =
        BlocProvider.of<VendingMachineBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  child: Image.asset(
                'assets/images/vending.jpg',
                fit: BoxFit.cover,
              ))
            ],
          )
        ],
      )),
    );
    // This trailing comma makes auto-formatting nicer for build methods
  }
}
