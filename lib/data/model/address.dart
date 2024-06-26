class LocationDetail {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  String? category;
  String? type;
  int? placeRank;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  LocationDetail(
      {this.placeId,
        this.licence,
        this.osmType,
        this.osmId,
        this.lat,
        this.lon,
        this.category,
        this.type,
        this.placeRank,
        this.importance,
        this.addresstype,
        this.name,
        this.displayName,
        this.address,
        this.boundingbox});

  LocationDetail.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    category = json['category'];
    type = json['type'];
    placeRank = json['place_rank'];
    importance = json['importance'];
    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['licence'] = licence;
    data['osm_type'] = osmType;
    data['osm_id'] = osmId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['category'] = category;
    data['type'] = type;
    data['place_rank'] = placeRank;
    data['importance'] = importance;
    data['addresstype'] = addresstype;
    data['name'] = name;
    data['display_name'] = displayName;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['boundingbox'] = boundingbox;
    return data;
  }
}

class Address {
  String? houseNumber;
  String? road;
  String? quarter;
  String? suburb;
  String? city;
  String? iSO31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address(
      {this.houseNumber,
        this.road,
        this.quarter,
        this.suburb,
        this.city,
        this.iSO31662Lvl4,
        this.postcode,
        this.country,
        this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    houseNumber = json['house_number'];
    road = json['road'];
    quarter = json['quarter'];
    suburb = json['suburb'];
    city = json['city'];
    iSO31662Lvl4 = json['ISO3166-2-lvl4'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['house_number'] = houseNumber;
    data['road'] = road;
    data['quarter'] = quarter;
    data['suburb'] = suburb;
    data['city'] = city;
    data['ISO3166-2-lvl4'] = iSO31662Lvl4;
    data['postcode'] = postcode;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
