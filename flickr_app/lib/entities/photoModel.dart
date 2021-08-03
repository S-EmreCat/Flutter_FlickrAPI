class Photo {
  String id;
  String owner;
  String title;
  String desc;
  String url;

  Photo({this.id, this.owner, this.title, this.desc, this.url});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    title = json['title'];
    desc = json['desc'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner'] = this.owner;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['url'] = this.url;
    return data;
  }
}
