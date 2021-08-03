import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/entities/searchModel.dart';
import 'package:stajproje/service/service.dart';
import 'package:stajproje/ui/detailPage.dart';
import 'package:stajproje/ui/searchPage.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

AppService appService = AppService();
TextEditingController searchController = new TextEditingController();

class _TestScreenState extends State<TestScreen> {
  SearchModel searchResult = new SearchModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  GetSizesModel getsizeResult = new GetSizesModel();
  String mypid;

  Future getsize(pid) async {
    getsizeResult = await service.getSizesResults(pid);
    return getsizeResult;
  }

  Future search(String searchKey) async {
    searchResult = await service.getSearchResults(searchKey, 1);
    return searchResult;
  }

  Future getinfo(pid) async {
    getinfoResult = await service.getInfoResults(pid);
    return getinfoResult;
  }

  Future pidgetir() async {
    mypid = await searchResult.photos.photo[4].id;
    return mypid;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
    // double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5E5),
        toolbarHeight: 50,
        title: Text(
          "Search Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                // TODO: Future.builder ile yapmayı dene sayfayı
                child: searchResult.photos == null
                    ? Container(
                        child: Center(
                          child: Text(""),
                        ),
                      )
                    : Text("future")),
            Container(
              height: sh / 13,
              child: (ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                  searchController.clear();
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Ink(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xffDBDBDB), Color(0xffeaeaea)]),
                    ),
                    constraints: BoxConstraints(minHeight: 50),
                    alignment: Alignment.center,
                    child: Text(
                      "Search Bar",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 125,
        child: Column(children: [
          Container(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: searchController,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Text",
                            hintStyle: TextStyle(
                              color: Color(0xff8D8D8D),
                            ),
                          ),
                          style: TextStyle(
                            color: Color(0xff8D8D8D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 50,
            child: (ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                search(searchController.text);
              },
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Ink(
                child: Container(
                  constraints: BoxConstraints(minHeight: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "Search",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )),
          )
        ]),
      ),
      actions: [],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
