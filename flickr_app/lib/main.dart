import 'package:flutter/material.dart';
import 'package:stajproje/ui/test.dart';
import 'package:stajproje/ui/searchPage.dart';

Future<void> main() async {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    debugShowCheckedModeBanner: false,
    home: GoogleMapScreen(),
  ));
}
