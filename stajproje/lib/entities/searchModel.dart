import 'package:stajproje/entities/photosModel.dart';

class SearchModel {
  Photos photos;
  String stat;

  SearchModel({this.photos, this.stat});

  SearchModel.fromJson(Map<String, dynamic> json) {
    photos =
        json['photos'] != null ? new Photos.fromJson(json['photos']) : null;
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photos != null) {
      data['photos'] = this.photos.toJson();
    }
    data['stat'] = this.stat;
    return data;
  }
}