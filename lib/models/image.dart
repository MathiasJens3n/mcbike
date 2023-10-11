class Image {
  int? id;
  int? productId;
  String base64;
  String name;

  Image({
    this.id,
    this.productId,
    required this.base64,
    required this.name,
  });
}
