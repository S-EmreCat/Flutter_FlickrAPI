class GetInfoModel {
  Photo photo;
  String stat;

  GetInfoModel({this.photo, this.stat});

  GetInfoModel.fromJson(Map<String, dynamic> json) {
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    data['stat'] = this.stat;
    return data;
  }
}

class Photo {
  String id;
  Owner owner;
  Title title;
  Title description;
  Location location;
  Urls urls;

  Photo({
    this.id,
    this.owner,
    this.title,
    this.description,
    this.location,
    this.urls,
  });

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? new Title.fromJson(json['description'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    return data;
  }
}

class Owner {
  String nsid;
  String username;

  Owner({
    this.nsid,
    this.username,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    nsid = json['nsid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nsid'] = this.nsid;
    data['username'] = this.username;
    return data;
  }
}

class Title {
  String sContent;

  Title({this.sContent});

  Title.fromJson(Map<String, dynamic> json) {
    sContent = json['_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_content'] = this.sContent;
    return data;
  }
}

class Location {
  String latitude;
  String longitude;
  String accuracy;
  String context;
  Title locality;
  Title county;
  Title region;
  Title country;
  Title neighbourhood;

  Location(
      {this.latitude,
      this.longitude,
      this.accuracy,
      this.context,
      this.locality,
      this.county,
      this.region,
      this.country,
      this.neighbourhood});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    accuracy = json['accuracy'];
    context = json['context'];
    locality =
        json['locality'] != null ? new Title.fromJson(json['locality']) : null;
    county = json['county'] != null ? new Title.fromJson(json['county']) : null;
    region = json['region'] != null ? new Title.fromJson(json['region']) : null;
    country =
        json['country'] != null ? new Title.fromJson(json['country']) : null;
    neighbourhood = json['neighbourhood'] != null
        ? new Title.fromJson(json['neighbourhood'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['accuracy'] = this.accuracy;
    data['context'] = this.context;
    if (this.locality != null) {
      data['locality'] = this.locality.toJson();
    }
    if (this.county != null) {
      data['county'] = this.county.toJson();
    }
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.neighbourhood != null) {
      data['neighbourhood'] = this.neighbourhood.toJson();
    }
    return data;
  }
}

class Urls {
  List<Url> url;

  Urls({this.url});

  Urls.fromJson(Map<String, dynamic> json) {
    if (json['url'] != null) {
      url = new List<Url>();
      json['url'].forEach((v) {
        url.add(new Url.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.url != null) {
      data['url'] = this.url.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Url {
  String type;
  String sContent;

  Url({this.type, this.sContent});

  Url.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    sContent = json['_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['_content'] = this.sContent;
    return data;
  }
}
