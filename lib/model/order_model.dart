class PlantModel {
  final String plantName;
  final String image;

  PlantModel({required this.plantName, required this.image});

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      plantName: json['plantname'] ?? "",
      image: json['image'] ?? "",
    );
  }
}

class OrderModel {
  final String orderId;
  final PlantModel plant;
  final int quantity;
  final String status;

  OrderModel({
    required this.orderId,
    required this.plant,
    required this.quantity,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['_id'] ?? "",
      plant: PlantModel.fromJson(json['plantId']),
      quantity: json['quantity'] ?? 1,
      status: json['status'] ?? "pending",
    );
  }
}
