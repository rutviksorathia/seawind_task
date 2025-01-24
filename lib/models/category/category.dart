class CategoryData {
  bool status;
  String message;
  List<Category> responsedata;

  CategoryData({
    required this.status,
    required this.message,
    required this.responsedata,
  });

  factory CategoryData.fromMap(Map<String, dynamic> map) {
    return CategoryData(
      status: map["status"],
      message: map["message"],
      responsedata: (map["responsedata"] as List)
          .map((el) => Category.fromMap(el))
          .toList(),
    );
  }
}

class Category {
  int id;
  String title;
  String slug;
  String content;
  String image;
  String hidImage;
  String icon;
  String hidIcon;
  int status;
  String entDt;

  Category({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.image,
    required this.hidImage,
    required this.icon,
    required this.hidIcon,
    required this.status,
    required this.entDt,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        content: map["Content"],
        id: map["Id"],
        hidIcon: map["Hid_Icon"],
        hidImage: map["Hid_Image"],
        icon: map["Icon"],
        image: map["Image"],
        slug: map["Slug"],
        status: map["Status"],
        title: map["Title"],
        entDt: map["EntDt"]);
  }
}
