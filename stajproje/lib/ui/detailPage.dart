import 'package:flutter/material.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/service/service.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String photoid;
  DetailPage({this.title, this.photoid});

  @override
  _DetailPageState createState() => _DetailPageState();
}

AppService appService = AppService();

// TODO: getSizes Apiden resim çekilecek.
class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
    double sw = MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).size.width);
    debugPrint(MediaQuery.of(context).size.height.toString());
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
                decoration: BoxDecoration(),
                height: (sh / 10) * 4,
                child: Center(
                    child: Image.network(
                  "https://live.staticflickr.com/65535/51336994303_e2163d33e7_s.jpg",
                )),
                padding: EdgeInsets.only(bottom: 2, top: 2),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                height: (sh / 10) * 4,
                child: Center(
                  child: Text("harita gelecek pid: +${widget.photoid}"),
                ),
              ),
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
