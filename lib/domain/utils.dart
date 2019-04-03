import 'package:flutter/material.dart';

String convertToPence(int amount) => (amount / 100).toStringAsFixed(2);

double getScreenWidth(BuildContext context) {
  final double screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  return screenWidth;
}