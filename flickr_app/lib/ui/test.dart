import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/service/service.dart';

class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen({Key key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

AppService appService = AppService();

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GetSizesModel getsizeResult = new GetSizesModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  getinfo() async {
    getinfoResult = await appService.getInfoResults("51343874272");
    return getinfoResult;
  }

  getsize() async {
    getsizeResult = await appService.getSizesResults("51345544525");
    return getsizeResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
              future: getinfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData &&
                    snapshot.connectionState != ConnectionState) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return Text(getinfoResult.photo.description.sContent);
                } else if (snapshot.hasError) {
                  return Text("error");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
          Container(
            child: FutureBuilder(
              future: getsize(),
              builder: (context, snapshot) {
                if (!snapshot.hasData &&
                    snapshot.connectionState != ConnectionState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return Text(getsizeResult.sizes.size[4].source.toString());
                } else if (snapshot.hasError) {
                  return Text("error");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
