import 'dart:convert';
import 'dart:io';

import 'package:stajproje/entities/getinfoModel.dart';
import 'package:stajproje/entities/getsizesModel.dart';
import 'package:stajproje/entities/searchModel.dart';

class AppService {
  String searchURL =
      "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=749dfa7bd06ca56054f0debbac7e99c0&text=";
  String getinfoURL =
      "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=749dfa7bd06ca56054f0debbac7e99c0&photo_id=";
  String getSizesURL =
      "https://www.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=749dfa7bd06ca56054f0debbac7e99c0&photo_id=";
  Future<String> httpGet(String _url) async {
    HttpClient client = new HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse(_url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    client.close();
    return await response.transform(utf8.decoder).join();
  }

  Future<SearchModel> getSearchResults(String searchString) async {
    var response = await httpGet(searchURL +
        searchString +
        "&has_geo=1&per_page=25&format=json&nojsoncallback=1");
    var data = json.decode(response);
    var result = SearchModel.fromJson(json.decode(response));
    if (data != null) {
      result = SearchModel.fromJson(data);
    }
    return result;
  }

  Future<GetInfoModel> getInfoResults(String getinfoString) async {
    var response = await httpGet(
        getinfoURL + getinfoString + "&format=json&nojsoncallback=1");
    var data = json.decode(response);
    var result = GetInfoModel.fromJson(json.decode(response));
    if (data != null) {
      result = GetInfoModel.fromJson(data);
    }
    return result;
  }

  Future<GetSizesModel> getSizesResults(String getSizesString) async {
    var response = await httpGet(
        getinfoURL + getSizesString + "&format=json&nojsoncallback=1");
    var data = json.decode(response);
    var result = GetSizesModel.fromJson(json.decode(response));
    if (data != null) {
      result = GetSizesModel.fromJson(data);
    }
    return result;
  }
}
