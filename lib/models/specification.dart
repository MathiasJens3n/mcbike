class Specification {
  int? id;
  int? productId;
  String name;
  String specDescription;

  Specification({
    this.id,
    this.productId,
    required this.name,
    required this.specDescription,
  });
}
