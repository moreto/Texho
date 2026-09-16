// To parse this JSON data, do
//
//     final cepModel = cepModelFromJson(jsonString);

import 'dart:convert';

CepModel cepModelFromJson(String str) => CepModel.fromJson(json.decode(str));

String cepModelToJson(CepModel data) => json.encode(data.toJson());

class CepModel {
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? unidade;
  final String? bairro;
  final String? localidade;
  final String? uf;
  final String? estado;
  final String? regiao;
  final String? ibge;
  final String? gia;
  final String? ddd;
  final String? siafi;

  CepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.unidade,
    this.bairro,
    this.localidade,
    this.uf,
    this.estado,
    this.regiao,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) => CepModel(
    cep: json["cep"],
    logradouro: json["logradouro"],
    complemento: json["complemento"],
    unidade: json["unidade"],
    bairro: json["bairro"],
    localidade: json["localidade"],
    uf: json["uf"],
    estado: json["estado"],
    regiao: json["regiao"],
    ibge: json["ibge"],
    gia: json["gia"],
    ddd: json["ddd"],
    siafi: json["siafi"],
  );

  Map<String, dynamic> toJson() => {
    "cep": cep,
    "logradouro": logradouro,
    "complemento": complemento,
    "unidade": unidade,
    "bairro": bairro,
    "localidade": localidade,
    "uf": uf,
    "estado": estado,
    "regiao": regiao,
    "ibge": ibge,
    "gia": gia,
    "ddd": ddd,
    "siafi": siafi,
  };
}
