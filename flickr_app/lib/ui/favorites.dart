import 'package:flutter/material.dart';
import 'package:stajproje/entities/photoModel.dart';
import 'package:stajproje/sqflitedb/photo_db_provider.dart';
import 'package:stajproje/ui/detailPage.dart';

class Favorites extends StatefulWidget {
  Favorites({Key key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Photo> allPhotos = <Photo>[];
  int clickedPhotoID;
  ScrollController _scrollController = new ScrollController();

  Future<void> futurefnx() async {
    return Future.delayed(Duration(seconds: 1), () => 1);
  }

  void getPhotos() async {
    var photoFuture = _databaseHelper.getAllNotes();
    await photoFuture.then((data) {
      print("data geliyo");
      setState(() {
        this.allPhotos = data;
      });
      return this.allPhotos;
    });
  }

  @override
  void initState() {
    super.initState();

    getPhotos();
    _scrollController.addListener(() {
      // print("pixels: " + _scrollController.position.pixels.toString());
      // print("extent" + _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint("scroll data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: Container(
          child: FutureBuilder(
            future: futurefnx(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (allPhotos.length == 0) {
                  return Center(
                    child: Text("beğenilen foto bulunamadı"),
                  );
                } else
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),

                    itemCount: allPhotos.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = allPhotos;

                      if (data.length > 0) {
                        return InkWell(
                          onTap: () {
                            debugPrint(data[index].id);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  title: data[index].title,
                                  photoid: data[index].id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 3,
                                color: Color(0xffEAEAEA),
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Container(
                              child: Row(
                                children: [
                                  if (data[index].url != null)
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 5, 2, 5),
                                      child: Image.network(
                                        data[index].url,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(3, 0, 1, 0),
                                    child: Container(
                                      width: 230,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 2, 0, 3),
                                            child: Text(
                                              data[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 2),
                                            child: Text(
                                              data[index].owner,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              child: (data[index].desc == "")
                                                  ? Text(
                                                      "no data",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 12),
                                                    )
                                                  : Text(
                                                      data[index].desc,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 12),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else
                        return Container(
                          child: Text("null"),
                        );
                    },
                    // padding: EdgeInsets.all(1),
                  );
              } else if (snapshot.hasError) {
                return Text("bağlantı hatası");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
