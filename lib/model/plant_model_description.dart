class PlantModelDescription {
  int? status;
  String? message;
  Data? data;

  PlantModelDescription({this.status, this.message, this.data});

  PlantModelDescription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
