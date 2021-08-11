class Photo {
  String id;
  String owner;
  String title;
  String desc;
  String url;
  bool isLiked;

  Photo({this.id, this.owner, this.title, this.desc, this.url, this.isLiked});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    title = json['title'];
    desc = json['desc'];
    url = json['url'];
    isLiked = json["isLiked"] is int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner'] = this.owner;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['url'] = this.url;
    data["isLiked"] = this.isLiked;

    return data;
  }
}
