class GetCartModel {
  int? status;
  String? message;
  List<Data>? data;

  GetCartModel({this.status, this.message, this.data});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  PlantId? plantId;
  String? userId;
  int? quantity;
  int? iV;
  int? price;

  Data(
      {this.sId,
        this.plantId,
        this.userId,
        this.quantity,
        this.iV,
        this.price});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    plantId =
    json['plantId'] != null ? new PlantId.fromJson(json['plantId']) : null;
    userId = json['userId'];
    quantity = json['quantity'];
    iV = json['__v'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.plantId != null) {
      data['plantId'] = this.plantId!.toJson();
    }
    data['userId'] = this.userId;
    data['quantity'] = this.quantity;
    data['__v'] = this.iV;
    data['price'] = this.price;
    return data;
  }
}

class PlantId {
  String? sId;
  String? plantname;
  String? description;
  String? type;
  String? image;
  String? status;
  String? category;
  int? price;
  String? createdAt;
  int? iV;

  PlantId(
      {this.sId,
        this.plantname,
        this.description,
        this.type,
        this.image,
        this.status,
        this.category,
        this.price,
        this.createdAt,
        this.iV});

  PlantId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    plantname = json['plantname'];
    description = json['description'];
    type = json['type'];
    image = json['image'];
    status = json['status'];
    category = json['category'];
    price = json['price'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plantname'] = this.plantname;
    data['description'] = this.description;
    data['type'] = this.type;
    data['image'] = this.image;
    data['status'] = this.status;
    data['category'] = this.category;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
