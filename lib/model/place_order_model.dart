class PlaceOrder {
  final String userId; // matches API
  final List<Map<String, dynamic>> products;
  final double total;   // must match everywhere
  final String status;

  PlaceOrder({
    required this.userId,
    required this.products,
    required this.total,  // match constructor param
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "products": products,
      "total": total, // match field name
      "status": status,
    };
  }
}
