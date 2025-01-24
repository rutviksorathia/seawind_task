class CityData {
  bool status;
  String message;
  List<City> responsedata;

  CityData({
    required this.status,
    required this.message,
    required this.responsedata,
  });

  factory CityData.fromMap(Map<String, dynamic> map) {
    return CityData(
      status: map["status"],
      message: map["message"],
      responsedata:
          (map["responsedata"] as List).map((el) => City.fromMap(el)).toList(),
    );
  }
}

class City {
  int Id;
  int countryId;
  String countryTitle;
  String title;
  String slug;
  String image;

  City({
    required this.Id,
    required this.countryId,
    required this.countryTitle,
    required this.title,
    required this.slug,
    required this.image,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      Id: map["Id"],
      countryId: map["CountryId"],
      countryTitle: map["CountryTitle"],
      title: map["Title"],
      slug: map["Slug"],
      image: map["Image"],
    );
  }
}
