class SliderData {
  bool status;
  String message;
  List<SliderItem> responsedata;

  SliderData({
    required this.status,
    required this.message,
    required this.responsedata,
  });

  factory SliderData.fromMap(Map<String, dynamic> map) {
    return SliderData(
      status: map["status"],
      message: map["message"],
      responsedata: (map["responsedata"] as List)
          .map((el) => SliderItem.fromMap(el))
          .toList(),
    );
  }
}

class SliderItem {
  int id;
  String title;
  String url;
  String image;

  SliderItem({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
  });

  factory SliderItem.fromMap(Map<String, dynamic> map) {
    return SliderItem(
      id: map["Id"],
      title: map["Title"],
      url: map["Url"],
      image: map["Image"],
    );
  }
}
