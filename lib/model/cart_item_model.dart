class CartItemModel {
  final String plantId;
  final String userId;
  final int quantity;
  final double price;
  final String name;
  final String imageUrl;

  CartItemModel({
    required this.plantId,
    required this.userId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.imageUrl,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      plantId: json['plantId'] ?? '',
      userId: json['userId'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "plantId": plantId,
      "userId": userId,
      "quantity": quantity,
      "price": price,
      "name": name,
      "imageUrl": imageUrl,
    };
  }
}
