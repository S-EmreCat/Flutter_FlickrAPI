import 'package:flutter/material.dart';
import 'package:stajproje/entities/searchModel.dart';
import 'package:stajproje/service/service.dart';
import 'package:stajproje/ui/detailPage.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

AppService service = new AppService();
TextEditingController searchController = new TextEditingController();

class _SearchPageState extends State<SearchPage> {
  SearchModel searchResult = new SearchModel();
  search(String searchKey) async {
    searchResult = await service.getSearchResults(searchKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5E5),
        toolbarHeight: 50,
        title: Text("Search Page", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: searchResult.photos == null
                    ? Container(child: Text(""))
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: searchResult.photos.photo.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = searchResult.photos.photo;
                          if (data.length > 0)
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            title: data[index].title.toString(),
                                          )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xffEAEAEA))),
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 3),
                                            child: Text(
                                                "title " + data[index].title,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 3),
                                            child: Text("ownerid: " +
                                                data[index].owner)),
                                        Container(
                                            width: sw,
                                            child: Text(
                                                "photo id:" + data[index].id,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12)))
                                      ],
                                    )));
                          else
                            return Container(child: Text("Sonuç bulunamadı"));
                        },
                        padding: EdgeInsets.all(1),
                      )),
            Container(
              height: sh / 13,
              child: (RaisedButton(
                onPressed: () {
                  showAlertDialog(context);
                  searchController.clear();
                },
                color: Colors.white,
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
                      "Arama",
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
        height: 150,
        child: Column(children: [
          Container(),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: Center(
                        child: TextFormField(
                          controller: searchController,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Text",
                              hintStyle: TextStyle(color: Color(0xff8D8D8D))),
                          style: TextStyle(color: Color(0xff8D8D8D)),
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
            child: (RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                search(searchController.text);
              },
              color: Colors.white,
              child: Ink(
                child: Container(
                  constraints: BoxConstraints(minHeight: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "Arama",
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

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
