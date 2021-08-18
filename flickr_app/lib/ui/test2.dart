import 'package:flutter/material.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/entities/searchModel.dart';
import 'package:stajproje/service/service.dart';
import 'package:stajproje/entities/photoModel.dart' as photo;

import 'package:stajproje/sqflitedb/photo_db_provider.dart';
import 'package:stajproje/ui/detailPage.dart';
import 'package:stajproje/ui/favorites.dart';

class TestScreennn extends StatefulWidget {
  TestScreennn({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TestScreennnState createState() => _TestScreennnState();
}

AppService service = new AppService();
TextEditingController searchController = new TextEditingController();

class _TestScreennnState extends State<TestScreennn> {
  SearchModel searchResult = new SearchModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  GetSizesModel getsizeResult = new GetSizesModel();
  ScrollController _scrollController = new ScrollController();

  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<photo.Photo> allPhotos = <photo.Photo>[];

  bool myisLiked = false;
  int mylen = 0;
  int page = 1;
  String lastSearchKey = "";
  @override
  void initState() {
    super.initState();

    debugPrint("run");
    _scrollController.addListener(() {
      // print("pixels: " + _scrollController.position.pixels.toString());
      // print("extent" + _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        search();
        debugPrint("scroll get data");
      }
    });
  }

  Future search() async {
    lastSearchKey = "istanbul";
    page = 0;
    if ("bursa" != lastSearchKey) {
      page = 1;
      searchResult = await service.getSearchResults("bursa", page);
      lastSearchKey = "bursa";
    } else {
      if (page < searchResult.photos.pages) {
        page = page + 1;
        var aa = await service.getSearchResults("Bursa", page);

        searchResult.photos.photo += aa.photos.photo;
      }
    }

    // print("search key: ${searchController.text}");

    return searchResult;
  }

  Future getsize(String pid) async {
    getsizeResult = await service.getSizesResults(pid);
    return getsizeResult;
  }

  Future getinfo(String pid) async {
    getinfoResult = await service.getInfoResults(pid);

    return getinfoResult;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future mydelete(id) async {
    await _databaseHelper.deleteList(int.parse(id));
  }

  void deletePhoto(id) {
    if (myisLiked == false) {
      mydelete(id);
      print("silindi");
    }
  }

  void getPhotos() async {
    allPhotos = await _databaseHelper.getAllNotes();

    for (var item in allPhotos) {
      if (item.id == getinfoResult.photo.id) {
        myisLiked = item.isLiked;
      }
    }
    print("denemee");
    setState(() {});
  }

  Future myinsert(photo.Photo myphoto) async {
    await _databaseHelper.insert(myphoto);
    print("eklendi");
    setState(() {
      getPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sdfg"),
      ),
      body: Container(
        // TODO: Future.builder ile yapmayı dene sayfayı
        child: searchResult.photos == null
            ? Container(
                child: Center(
                  child: FloatingActionButton(
                    child: Text("click"),
                    onPressed: () async => {
                      print("sdfasdf"),
                      await search(),
                      setState(() {}),
                    },
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchResult.photos.photo.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  var data = searchResult.photos.photo;
                  print(searchResult.photos.photo.length);
                  if (data.length > 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: Container(
                            height: 100,
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FutureBuilder<List>(
                                future: Future.wait([
                                  search(),
                                  getsize(data[index].id.toString()),
                                  getinfo(data[index].id.toString()),
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 3,
                                            color: Color(0xffEAEAEA),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(snapshot
                                                .data[1].sizes.size[0].source),
                                            Text(data[index].title),
                                            Text(index.toString()),
                                            Text(snapshot
                                                .data[2].photo.owner.username)
                                          ],
                                        ));
                                  } else if (snapshot.hasError) {
                                    return Text("error");
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (data.length == 0)
                    return Container(
                      child: Text("0 data"),
                    );
                  else
                    return Container(child: Text("null"));
                }),
      ),
    );
  }
}
