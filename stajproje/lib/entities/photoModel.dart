class Photo {
  String id;
  String owner;
  String title;

  Photo({
    this.id,
    this.owner,
    this.title,
  });

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner'] = this.owner;
    data['title'] = this.title;
    return data;
  }
}
