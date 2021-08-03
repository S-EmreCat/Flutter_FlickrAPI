class GetSizesModel {
  Sizes sizes;
  String stat;

  GetSizesModel({this.sizes, this.stat});

  GetSizesModel.fromJson(Map<String, dynamic> json) {
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sizes != null) {
      data['sizes'] = this.sizes.toJson();
    }
    data['stat'] = this.stat;
    return data;
  }
}

class Sizes {
  int canblog;
  int canprint;
  int candownload;
  List<Size> size;

  Sizes({this.canblog, this.canprint, this.candownload, this.size});

  Sizes.fromJson(Map<String, dynamic> json) {
    canblog = json['canblog'];
    canprint = json['canprint'];
    candownload = json['candownload'];
    if (json['size'] != null) {
      // ignore: deprecated_member_use
      size = new List<Size>();
      json['size'].forEach((v) {
        size.add(new Size.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canblog'] = this.canblog;
    data['canprint'] = this.canprint;
    data['candownload'] = this.candownload;
    if (this.size != null) {
      data['size'] = this.size.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  String label;
  String source;
  String url;
  String media;

  Size({this.label, this.source, this.url, this.media});

  Size.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    source = json['source'];
    url = json['url'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['source'] = this.source;
    data['url'] = this.url;
    data['media'] = this.media;
    return data;
  }
}
