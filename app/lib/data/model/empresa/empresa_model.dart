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
  final String? emprCodigo;

  EmpresaModel({required this.emprId, required this.emprUuid, required this.emprNome, this.emprCodigo});

  factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
    emprId: json['emprId'] ?? json['empr_id'],
    emprUuid: json['emprUuid'] ?? json['empr_uuid'],
    emprNome: json['emprNome'] ?? json['empr_nome'],
    emprCodigo: json['emprCodigo'] ?? json['emprCodigo'],
  );

  Map<String, dynamic> toJson() => {
    'empr_id': emprId,
    'empr_uuid': emprUuid,
    'empr_nome': emprNome,
    'emprCodigo': emprCodigo,
  };
}
