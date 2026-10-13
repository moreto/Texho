// To parse this JSON data, do
//
//     final empresaModel = empresaModelFromJson(jsonString);

import 'dart:convert';

EmpresaModel empresaModelFromJson(String str) => EmpresaModel.fromJson(json.decode(str));

String empresaModelToJson(EmpresaModel data) => json.encode(data.toJson());

class EmpresaModel {
  final String emprNome;

  EmpresaModel({required this.emprNome});

  factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(emprNome: json['emprNome']);

  Map<String, dynamic> toJson() => {'emprNome': emprNome};
}
