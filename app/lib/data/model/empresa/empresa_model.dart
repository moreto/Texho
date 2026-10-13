// To parse this JSON data, do
//
//     final empresaModel = empresaModelFromJson(jsonString);

import 'dart:convert';

EmpresaModel empresaModelFromJson(String str) => EmpresaModel.fromJson(json.decode(str));

String empresaModelToJson(EmpresaModel data) => json.encode(data.toJson());

class EmpresaModel {
  final int emprId;
  final String emprUuid;
  final String emprNome;

  EmpresaModel({required this.emprId, required this.emprUuid, required this.emprNome});

  factory EmpresaModel.fromJson(Map<String, dynamic> json) =>
      EmpresaModel(emprId: json['empr_id'], emprUuid: json['empr_uuid'], emprNome: json['empr_nome']);

  Map<String, dynamic> toJson() => {'empr_id': emprId, 'empr_uuid': emprUuid, 'empr_nome': emprNome};
}
