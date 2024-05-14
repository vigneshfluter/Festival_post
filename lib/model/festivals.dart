class Festivals {
  int id;
  String name;
  String image;
  List<String> images;

  Festivals(
      {required this.id,
      required this.name,
      required this.image,
      required this.images});

  factory Festivals.fromMap(Map<String, dynamic> data) {
    return Festivals(
        id: data["id"],
        name: data["name"],
        image: data["image"],
        images: data["images"]);
  }
}
