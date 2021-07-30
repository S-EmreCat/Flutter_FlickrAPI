import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/entities/searchModel.dart';
import 'package:stajproje/service/service.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

AppService appService = AppService();

class _TestScreenState extends State<TestScreen> {
  GetSizesModel getsizeResult = new GetSizesModel();
  GetInfoModel getinfoResult = new GetInfoModel();
  SearchModel searchResult = new SearchModel();
  // GetSizesModel getsizeResult = new GetSizesModel();
  List<String> myownameslist = [];
  List<String> mydesclist = [];
  List<String> myimagelist = [];

  // TODO: Future olmadan çalıştırmayı dene
  // FIXME: 20 saniye gecikmeli yükleniyor veriler
  search(String searchKey) async {
    searchResult = await appService.getSearchResults(searchKey);
    // getinfofnc();
    for (var i in searchResult.photos.photo) {
      getinfoResult = await appService.getInfoResults(i.id);
      myownameslist.add(getinfoResult.photo.owner.username);
      mydesclist.add(getinfoResult.photo.description.sContent);
      myimagelist.add(getsizeResult.sizes.size[0].source);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map"),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 25,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                    height: 100,
                    child: IconTheme(
                        data: IconThemeData(color: Color(0xFF3A5A98)),
                        child: Image.network(
                            "https://live.staticflickr.com/65535/51344867566_469afae4bd_s.jpg"))),
              );
            },
          ),
        ));
  }
}
