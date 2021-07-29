import 'package:stajproje/entities/photoModel.dart';

class Photos {
  int page;
  int pages;
  int perpage;
  int total;
  List<Photo> photo;

  Photos({this.page, this.pages, this.perpage, this.total, this.photo});

  Photos.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pages = json['pages'];
    perpage = json['perpage'];
    total = json['total'];
    if (json['photo'] != null) {
      // ignore: deprecated_member_use
      photo = new List<Photo>();
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pages'] = this.pages;
    data['perpage'] = this.perpage;
    data['total'] = this.total;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
