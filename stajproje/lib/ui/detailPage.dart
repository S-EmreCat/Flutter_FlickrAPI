import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String title;
  DetailPage({this.title});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("kafayı yedim Page"),
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
                  child:
                      Center(child: Text("getSizeApide source küçük resim"))),
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
