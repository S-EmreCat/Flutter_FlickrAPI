import 'package:flutter/material.dart';
import 'package:stajproje/ui/searchPage.dart';
import 'package:stajproje/ui/test.dart';

Future<void> main() async {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    debugShowCheckedModeBanner: false,
    home: TestScreen(),
  ));
}
