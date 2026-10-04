// To parse this JSON data, do
//
//     final accessModel = accessModelFromJson(jsonString);

import 'dart:convert';

AccessModel accessModelFromJson(String str) => AccessModel.fromJson(json.decode(str));

String accessModelToJson(AccessModel data) => json.encode(data.toJson());

class AccessModel {
  final String usuaEmail;
  final String usuaSenha;
  final String usuaUuid;

  AccessModel({required this.usuaEmail, required this.usuaSenha, required this.usuaUuid});

  factory AccessModel.fromJson(Map<String, dynamic> json) =>
      AccessModel(usuaEmail: json['usuaEmail'], usuaSenha: json['usuaSenha'], usuaUuid: json['usuaUuid']);

  Map<String, dynamic> toJson() => {'usuaEmail': usuaEmail, 'usuaSenha': usuaSenha, 'usuaUuid': usuaUuid};
}
