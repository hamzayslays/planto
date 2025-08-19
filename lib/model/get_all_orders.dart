class GetOrders {
  String? status;
  int? results;
  Data? data;

  GetOrders({this.status, this.results, this.data});

  GetOrders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Order>? order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  String? sId;
  Customer? customer;
  List<Products>? products;
  int? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Order(
      {this.sId,
        this.customer,
        this.products,
        this.total,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Customer {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Customer(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  Product? product;
  int? quantity;
  String? sId;

  Products({this.product, this.quantity, this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}

class Product {
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
