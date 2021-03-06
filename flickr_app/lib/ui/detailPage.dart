import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getlocationModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/service/service.dart';
import 'package:stajproje/entities/photoModel.dart' as photo;
import 'package:stajproje/sqflitedb/photo_db_provider.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:stajproje/ui/searchPage.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String photoid;
  DetailPage({this.title, this.photoid});

  @override
  _DetailPageState createState() => _DetailPageState();
}

AppService appService = AppService();

// TODO: getSizes Apiden resim ├žekilecek.
class _DetailPageState extends State<DetailPage> {
  GetSizesModel getsizeResult = new GetSizesModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<photo.Photo> allPhotos = <photo.Photo>[];
  int clickedPhotoID;

  bool myisLiked = false;
  @override
  void initState() {
    super.initState();
    getPhotos();
    setState(() {});
  }

  void getPhotos() async {
    allPhotos = await _databaseHelper.getAllNotes();

    for (var item in allPhotos) {
      if (item.id == widget.photoid) {
        myisLiked = item.isLiked;
      }
      // setState(() {});
    }

    setState(() {});
  }

  Future getsize() async {
    getsizeResult = await appService.getSizesResults(widget.photoid);
    return getsizeResult;
  }

  Future getlocation() async {
    getinfoResult = await service.getInfoResults(widget.photoid);
    return getinfoResult;
  }

  Future myinsert(photo.Photo myphoto) async {
    await _databaseHelper.insert(myphoto);
  }

  Future mydelete() async {
    await _databaseHelper.deleteList(int.parse(getinfoResult.photo.id));
  }

  void deletePhoto() {
    if (myisLiked == false) {
      mydelete();
      print("silindi");
    }
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

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50 - 50;
    //double sw = MediaQuery.of(context).size.width;
    debugPrint("pid: " + widget.photoid);
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
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${widget.title}"),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                          myisLiked ? Icons.favorite : Icons.favorite_outline,
                          color: myisLiked ? Colors.red : Colors.greenAccent),
                      iconSize: 25,
                      onPressed: () {
                        setState(
                          () {
                            myisLiked = !myisLiked;
                            myisLiked ? savePhoto() : deletePhoto();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                // TODO: border ─▒n alt─▒na ├žizgi eklenip harita ile resim ayr─▒lacak
                // Divider(color: Colors.black, thickness:2)
                // decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                height: (sh / 10) * 4.5,
                child: FutureBuilder(
                  future: getsize(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData &&
                        snapshot.connectionState != ConnectionState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return Image.network(
                        getsizeResult.sizes.size[4].source.toString(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("error");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              Divider(
                height: 10,
                color: Colors.black,
                thickness: 2,
              ),
              Container(
                decoration: BoxDecoration(),
                height: (sh / 10) * 4.5,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: FutureBuilder(
                      future: getlocation(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData &&
                            snapshot.connectionState != ConnectionState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return GoogleMap(
                            mapType: MapType.satellite,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(
                                    getinfoResult.photo.location.latitude),
                                double.parse(
                                    getinfoResult.photo.location.longitude),
                              ),
                              zoom: 14,
                            ),
                            markers: _cretaeMarker(),
                          );
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
          ),
        ),
      ),
    );
  }

  Set<Marker> _cretaeMarker() {
    if (getinfoResult.photo.location.locality == null)
      return <Marker>[
        Marker(
          infoWindow:
              InfoWindow(title: getinfoResult.photo.location.country.sContent),
          markerId: MarkerId("1"),
          position: LatLng(
            double.parse(getinfoResult.photo.location.latitude),
            double.parse(getinfoResult.photo.location.longitude),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        ),
      ].toSet();
    else
      return <Marker>[
        Marker(
          infoWindow:
              InfoWindow(title: getinfoResult.photo.location.locality.sContent),
          markerId: MarkerId("2"),
          position: LatLng(
            double.parse(getinfoResult.photo.location.latitude),
            double.parse(getinfoResult.photo.location.longitude),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        ),
      ].toSet();
  }
}
