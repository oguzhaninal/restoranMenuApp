// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/constants/customColors.dart';
import 'package:sambaposapp/view/basket.dart';

import 'core/locator.dart';
import 'view/home.dart';

void main() {
  setUpLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: customColors.mainRed,
      )),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
