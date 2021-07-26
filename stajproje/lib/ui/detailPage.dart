import 'package:flutter/material.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/service/service.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String photoid;
  DetailPage({this.title, this.photoid});

  @override
  _DetailPageState createState() => _DetailPageState();
}

AppService appService = AppService();

class _DetailPageState extends State<DetailPage> {
  GetInfoModel getinfoResult = GetInfoModel();

  getinfofnc(String pid) async {
    getinfoResult = await appService.getInfoResults(pid);
  }

  @override
  void initState() {
    getinfofnc("${widget.photoid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("Detail Page"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  height: sh / 12,
                  child: Center(child: Text("${widget.title}"))),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                height: (sh / 10) * 4,
                child: Center(
                  child: Text("resim"),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  height: (sh / 10) * 4,
                  child: Center(child: Text("harita"))),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                height: sh / 14,
                width: sw,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blueGrey[100]),
                  onPressed: () {
                    debugPrint("clicked");
                    Navigator.pop(context);
                  },
                  child: Ink(
                    child: Container(
                      width: sw,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xffDBDBDB),
                            Color(0xffeaeaea),
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "geri git",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
