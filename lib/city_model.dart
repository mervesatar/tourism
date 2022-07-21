class Place {
  late String name;
  late String intro;
  late String full;
  late String landing;
  late double latitude;
  late double longitude;
  late List<dynamic> alternative;

  Place(this.name, this.intro, this.full,this.landing,this.alternative,this.latitude,this.longitude);

  Place.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        intro = json['intro'],
        full = json['full'],
        landing = json['landing'],
        alternative = json['alternative'].toList(),
        latitude = json['latitude'],
        longitude = json['longitude'];
  Map<String, dynamic> toJson() => {
    'name': name,
    'intro': intro,
    'full': full,
    'landing': landing,
    'alternative': alternative,
    'latitude': latitude,
    'longitude': longitude,
  };
}