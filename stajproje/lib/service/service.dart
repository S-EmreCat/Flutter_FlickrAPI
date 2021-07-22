import 'dart:convert';
import 'dart:io';

import 'package:stajproje/entities/searchModel.dart';

class AppService {
  String searchURL =
      "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=749dfa7bd06ca56054f0debbac7e99c0&text=";

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
        "&per_page=25&page=1&format=json&nojsoncallback=1");
    var data = json.decode(response);
    var result = SearchModel.fromJson(json.decode(response));
    if (data != null) {
      result = SearchModel.fromJson(data);
    }
    return result;
  }
}
