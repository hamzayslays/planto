class PlaceOrder {
  final String userId;
  final String products;
  final double totalAmount;
  final String status;
  final int quantity;

  PlaceOrder({
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "products": products,
      "totalAmount": totalAmount,
      "status": status,
      "quantity": quantity,
    };
  }
}
