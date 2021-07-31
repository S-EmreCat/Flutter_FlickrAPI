import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/entities/searchModel.dart';
import 'package:stajproje/service/service.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

AppService appService = AppService();

class _TestScreenState extends State<TestScreen> {
  GetSizesModel getsizeResult = new GetSizesModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  SearchModel searchResult = new SearchModel();
  // GetSizesModel getsizeResult = new GetSizesModel();
  List<String> myownameslist = [];
  List<String> mydesclist = [];
  List<String> myimagelist = [];

  // TODO: Future olmadan çalıştırmayı dene
  // FIXME: 20 saniye gecikmeli yükleniyor veriler

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: mybody(),
    );
  }

  mybody() {
    return Container();
  }
}
