class Data {
  bool status;
  String message;
  List<Country> responsedata;

  Data({
    required this.status,
    required this.message,
    required this.responsedata,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      status: map["status"],
      message: map["message"],
      responsedata: (map["responsedata"] as List)
          .map((el) => Country.fromMap(el))
          .toList(),
    );
  }
}

class Country {
  int Id;
  String title;
  String slug;
  String image;

  Country({
    required this.Id,
    required this.title,
    required this.slug,
    required this.image,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      Id: map["Id"],
      title: map["Title"],
      slug: map["Slug"],
      image: map["Image"],
    );
  }
}
