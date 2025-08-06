class AddToCartModel {
  final String plantId;
  final String userId;
  final int quantity;
  final double price;

  AddToCartModel({
    required this.plantId,
    required this.userId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "plantId": plantId,
      "userId": userId,
      "quantity": quantity,
      "price": price,
    };
  }
}
