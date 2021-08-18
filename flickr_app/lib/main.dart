import 'package:flutter/material.dart';
import 'package:stajproje/ui/searchPage.dart';
import 'package:stajproje/ui/test.dart';
import 'package:stajproje/ui/test2.dart';

Future<void> main() async {
  runApp(MaterialApp(
    // showPerformanceOverlay: true,
    theme: ThemeData(primarySwatch: Colors.indigo),
    debugShowCheckedModeBanner: false,
    home: TestScreen(),
  ));
}
