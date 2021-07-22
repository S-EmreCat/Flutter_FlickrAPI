class Photo {
  String id;
  String owner;
  String secret;
  String server;
  int farm;
  String title;
  int ispublic;
  int isfriend;
  int isfamily;

  Photo(
      {this.id,
      this.owner,
      this.secret,
      this.server,
      this.farm,
      this.title,
      this.ispublic,
      this.isfriend,
      this.isfamily});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    secret = json['secret'];
    server = json['server'];
    farm = json['farm'];
    title = json['title'];
    ispublic = json['ispublic'];
    isfriend = json['isfriend'];
    isfamily = json['isfamily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner'] = this.owner;
    data['secret'] = this.secret;
    data['server'] = this.server;
    data['farm'] = this.farm;
    data['title'] = this.title;
    data['ispublic'] = this.ispublic;
    data['isfriend'] = this.isfriend;
    data['isfamily'] = this.isfamily;
    return data;
  }
}