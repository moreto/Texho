class EmpresaUsuarioModel {
  const EmpresaUsuarioModel({
    required this.emprId,
    required this.emprNome,
    required this.usuaId,
    required this.usuaEmail,
    this.udetNome,
    this.udetUsuario,
  });

  final int emprId;
  final String emprNome;
  final int usuaId;
  final String usuaEmail;
  final String? udetNome;
  final String? udetUsuario;

  factory EmpresaUsuarioModel.fromJson(Map<String, dynamic> json) {
    final emprId = json['emprId'] ?? json['empr_id'];
    final usuaId = json['usuaId'] ?? json['usua_id'];

    return EmpresaUsuarioModel(
      emprId: (emprId as num).toInt(),
      emprNome: (json['emprNome'] ?? json['empr_nome']) as String,
      usuaId: (usuaId as num).toInt(),
      usuaEmail: (json['usuaEmail'] ?? json['usua_email']) as String,
      udetNome: json['udetNome'] as String? ?? json['udet_nome'] as String?,
      udetUsuario: json['udetUsuario'] as String? ?? json['udet_usuario'] as String?,
    );
  }
}
