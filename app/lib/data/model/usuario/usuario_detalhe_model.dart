// To parse this JSON data, do
//
//     final usuarioDetalheModel = usuarioDetalheModelFromJson(jsonString);

import 'dart:convert';

UsuarioDetalheModel usuarioDetalheModelFromJson(String str) => UsuarioDetalheModel.fromJson(json.decode(str));

String usuarioDetalheModelToJson(UsuarioDetalheModel data) => json.encode(data.toJson());

class UsuarioDetalheModel {
  final int usuaId;
  final String usuaUuid;
  final String usuaEmail;
  final bool usuaAtivo;
  final String udetNome;
  final String udetUsuario;

  UsuarioDetalheModel({
    required this.usuaId,
    required this.usuaUuid,
    required this.usuaEmail,
    required this.usuaAtivo,
    required this.udetNome,
    required this.udetUsuario,
  });

  factory UsuarioDetalheModel.fromJson(Map<String, dynamic> json) => UsuarioDetalheModel(
    usuaId: json['usuaId'],
    usuaUuid: json['usuaUuid'],
    usuaEmail: json['usuaEmail'],
    usuaAtivo: json['usuaAtivo'],
    udetNome: json['udetNome'],
    udetUsuario: json['udetUsuario'],
  );

  Map<String, dynamic> toJson() => {
    'usuaId': usuaId,
    'usuaUuid': usuaUuid,
    'usuaEmail': usuaEmail,
    'usuaAtivo': usuaAtivo,
    'udetNome': udetNome,
    'udetUsuario': udetUsuario,
  };
}
