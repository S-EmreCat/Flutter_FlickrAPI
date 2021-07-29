import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/service/service.dart';

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

// TODO: getSizes Apiden resim çekilecek.
class _DetailPageState extends State<DetailPage> {
  GetSizesModel getsizeResult = new GetSizesModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  Future getsize(String searchKey) async {
    service.getSizesResults(searchKey).then((value) {
      getsizeResult = value;
      setState(() {});
    });
  }

  Future getlocation(String pid) async {
    service.getInfoResults(pid).then((value) {
      getinfoResult = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getsize(widget.photoid);
    getlocation(widget.photoid);
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50;
    double sw = MediaQuery.of(context).size.width;
    debugPrint("pid: " + widget.photoid);
    debugPrint("w: " + MediaQuery.of(context).size.width.toString());
    debugPrint("h: " + MediaQuery.of(context).size.height.toString());
    debugPrint("photo h: " + ((sh / 10) * 4).toString());
    Location location = getinfoResult.photo.location;
    String lati = location.latitude;
    String long = location.longitude;

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
                child: Center(
                  child: Text("${widget.title}"),
                ),
              ),
              if (getsizeResult.sizes != null)
                Container(
                  decoration: BoxDecoration(),
                  height: (sh / 10) * 4,
                  child: Image.network(getsizeResult.sizes.size[4].source),
                ),
              if (getsizeResult.sizes == null)
                Container(
                  decoration: BoxDecoration(),
                  height: (sh / 10) * 4,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                ),
                height: (sh / 10) * 4,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: (getinfoResult == null)
                        ? Text("yükleniyor")
                        : GoogleMap(
                            mapType: MapType.hybrid,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(lati),
                                double.parse(long),
                              ),
                              zoom: 14,
                            ),
                            markers: _cretaeMarker(),
                          ),
                  ),
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

  Set<Marker> _cretaeMarker() {
    return <Marker>[
      Marker(
          infoWindow:
              InfoWindow(title: getinfoResult.photo.location.locality.sContent),
          markerId: MarkerId("asdasd"),
          position: LatLng(
            double.parse(getinfoResult.photo.location.latitude),
            double.parse(getinfoResult.photo.location.longitude),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
    ].toSet();
  }
}
