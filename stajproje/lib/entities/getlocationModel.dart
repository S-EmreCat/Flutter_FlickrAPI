class getLocation {
  Photo photo;
  String stat;

  getLocation({this.photo, this.stat});

  getLocation.fromJson(Map<String, dynamic> json) {
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
  Location location;

  Photo({this.id, this.location});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Location {
  String latitude;
  String longitude;
  String accuracy;
  String context;
  Locality locality;
  Locality county;
  Locality region;
  Locality country;
  Locality neighbourhood;

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
    locality = json['locality'] != null
        ? new Locality.fromJson(json['locality'])
        : null;
    county =
        json['county'] != null ? new Locality.fromJson(json['county']) : null;
    region =
        json['region'] != null ? new Locality.fromJson(json['region']) : null;
    country =
        json['country'] != null ? new Locality.fromJson(json['country']) : null;
    neighbourhood = json['neighbourhood'] != null
        ? new Locality.fromJson(json['neighbourhood'])
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

class Locality {
  String sContent;

  Locality({this.sContent});

  Locality.fromJson(Map<String, dynamic> json) {
    sContent = json['_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_content'] = this.sContent;
    return data;
  }
}
