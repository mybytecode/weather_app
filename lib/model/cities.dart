class Cities {
  final String cityName;
  final String imgUrl;
  final double lat;
  final double long;

  Cities({this.cityName, this.imgUrl, this.lat, this.long});

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      cityName: json['city_name'],
      imgUrl: json['img_url'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['img_url'] = this.imgUrl;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
