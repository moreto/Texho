// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final int usuaId;
  final String token;

  LoginModel({required this.usuaId, required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(usuaId: json['usuaId'], token: json['token']);

  Map<String, dynamic> toJson() => {'usuaId': usuaId, 'token': token};
}
