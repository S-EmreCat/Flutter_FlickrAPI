import 'package:flutter/material.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/entities/searchModel.dart';
import 'package:stajproje/service/service.dart';
import 'package:stajproje/entities/photoModel.dart' as photo;

import 'package:stajproje/sqflitedb/photo_db_provider.dart';
import 'package:stajproje/ui/detailPage.dart';
import 'package:stajproje/ui/favorites.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

AppService service = new AppService();
TextEditingController searchController = new TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  SearchModel searchResult = new SearchModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  GetSizesModel getsizeResult = new GetSizesModel();

  ScrollController _scrollController = new ScrollController();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<photo.Photo> allPhotos = <photo.Photo>[];
  int clickedPhotoID;

  bool myisLiked = false;
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
        search(lastSearchKey);

        debugPrint("scroll get data");
      }
    });
  }

  getsize(String pid) async {
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
    setState(() {});
  }

  Future myinsert(photo.Photo myphoto) async {
    await _databaseHelper.insert(myphoto);
  }

  void savePhoto() {
    if (myisLiked == true) {
      myinsert(
        photo.Photo(
            desc: getinfoResult.photo.description.sContent,
            title: getinfoResult.photo.title.sContent,
            owner: getinfoResult.photo.owner.username,
            url: getsizeResult.sizes.size[0].source,
            id: getinfoResult.photo.id,
            isLiked: myisLiked),
      );
      print("kaydedildi");
    }
  }

  search(String searchKey) async {
    if (searchKey != lastSearchKey) {
      page = 1;
      lastSearchKey = searchKey;
      searchResult = await service.getSearchResults(searchKey, page);
    } else {
      if (page < searchResult.photos.pages) {
        page = page + 1;
        var aa = await service.getSearchResults(searchKey, page);
        searchResult.photos.photo += aa.photos.photo;
      }
    }
    setState(() {});
    print("search key: ${searchController.text}");
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
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
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: searchResult.photos.photo.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = searchResult.photos.photo;

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
                              child: Row(
                                children: [
                                  if (data[index].url == null)
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 5, 2, 5),
                                      child: FutureBuilder(
                                          future: getsize(data[index].id),
                                          builder: (context, snapshoturl) {
                                            if (snapshoturl.hasData) {
                                              return Image.network(
                                                getsizeResult
                                                    .sizes.size[0].source
                                                    .toString(),
                                              );
                                            } else if (snapshoturl.hasError) {
                                              return Text("error");
                                            }
                                            return Text("");
                                          }),
                                    ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(3, 0, 1, 0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 2, 0, 3),
                                              child: Text(
                                                data[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            FutureBuilder(
                                                future: getinfo(data[index].id),
                                                builder:
                                                    (context, snapshotinfo) {
                                                  if (snapshotinfo.hasData) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Text(
                                                            getinfoResult.photo
                                                                .owner.username,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Container(
                                                            child: (getinfoResult
                                                                        .photo
                                                                        .description
                                                                        .sContent ==
                                                                    "")
                                                                ? Text(
                                                                    "no data",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                : Text(
                                                                    getinfoResult
                                                                        .photo
                                                                        .description
                                                                        .sContent,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else if (snapshotinfo
                                                      .hasError) {
                                                    return Text("error");
                                                  }
                                                  return Text("");
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        data[index].isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: data[index].isLiked
                                            ? Colors.red
                                            : Colors.greenAccent),
                                    iconSize: 25,
                                    onPressed: () {
                                      setState(
                                        () {
                                          myisLiked = !myisLiked;
                                          myisLiked
                                              ? myinsert(photo.Photo(
                                                  desc: getinfoResult.photo
                                                      .description.sContent,
                                                  id: getinfoResult.photo.id,
                                                  url: getsizeResult
                                                      .sizes.size[0].source,
                                                  title: getinfoResult
                                                      .photo.title.sContent,
                                                  owner: getinfoResult
                                                      .photo.owner.username,
                                                  isLiked: data[index].isLiked))
                                              : deletePhoto(searchResult
                                                  .photos.photo[index].id);
                                          setState(() {
                                            data[index].isLiked = myisLiked;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (searchResult.photos.photo.length == 0) {
                          return Container(
                            child: Text("sonuç bulunamadı"),
                          );
                        } else
                          return Container(
                            child: Text("null"),
                          );
                      },
                    ),
            ),
            Container(
              height: sh / 10.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 10) * 4.95,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Favorites(),
                          ),
                        );
                        debugPrint("favorites buton clicked");
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
                            "Favorites",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 10) * 4.95,
                    child: ElevatedButton(
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
                    ),
                  ),
                ],
              ),
            ),
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
