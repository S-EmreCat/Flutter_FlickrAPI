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

  getsize() async {
    getsizeResult = await service.getSizesResults(widget.photoid);
    return getsizeResult;
  }

  Future getlocation() async {
    getinfoResult = await service.getInfoResults(widget.photoid);
    return getinfoResult;
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height - 50 - 50;
    //double sw = MediaQuery.of(context).size.width;
    debugPrint("pid: " + widget.photoid);
    debugPrint("w: " + MediaQuery.of(context).size.width.toString());
    debugPrint("h: " + MediaQuery.of(context).size.height.toString());
    debugPrint("photo h: " + ((sh / 10) * 4).toString());
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
                child: Center(
                  child: Text("${widget.title}"),
                ),
              ),
              Container(
                // TODO: border ın altına çizgi eklenip harita ile resim ayrılacak
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                height: (sh / 10) * 4.75,
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
              Container(
                decoration: BoxDecoration(),
                height: (sh / 10) * 4.75,
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
              // TODO: KALDIR
              // Container(
              //   decoration: BoxDecoration(),
              //   height: sh / 14,
              //   width: sw,
              //   child: ElevatedButton(
              //     style:
              //         ElevatedButton.styleFrom(primary: Colors.blueGrey[100]),
              //     onPressed: () {
              //       debugPrint("clicked");
              //       Navigator.pop(context);
              //     },
              //     child: Ink(
              //       child: Container(
              //         width: sw,
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             begin: Alignment.topLeft,
              //             end: Alignment.bottomRight,
              //             colors: [
              //               Color(0xffDBDBDB),
              //               Color(0xffeaeaea),
              //             ],
              //           ),
              //         ),
              //         alignment: Alignment.center,
              //
              //         child: Text(
              //           "Back",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(color: Colors.black),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),
    ].toSet();
  }
}
