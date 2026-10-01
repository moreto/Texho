// To parse this JSON data, do
//
//     final accessBodyModel = accessBodyModelFromJson(jsonString);

import 'dart:convert';

AccessBodyModel accessBodyModelFromJson(String str) => AccessBodyModel.fromJson(json.decode(str));

String accessBodyModelToJson(AccessBodyModel data) => json.encode(data.toJson());

class AccessBodyModel {
  final String email;
  final String senha;

  AccessBodyModel({required this.email, required this.senha});

  factory AccessBodyModel.fromJson(Map<String, dynamic> json) =>
      AccessBodyModel(email: json["email"], senha: json["senha"]);

  Map<String, dynamic> toJson() => {"email": email, "senha": senha};
}
