
class ItemModel {
  final String title;
  final int price;
  final String image;
  final String description;
  bool isFavourite;

  ItemModel({
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    this.isFavourite = false
  });
}
