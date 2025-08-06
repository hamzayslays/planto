// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? msg;
  String? token;
  Users? users;

  UserModel({this.msg, this.token, this.users});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    msg: json["msg"],
    token: json["Token"],
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "Token": token,
    "users": users?.toJson(),
  };
}

class Users {
  String? id;
  String? name;
  String? email;
  String? password;

  Users({this.id, this.name, this.email, this.password});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
  };
}
