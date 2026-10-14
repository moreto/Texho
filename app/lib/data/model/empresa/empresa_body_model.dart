class EmpresaBodyModel {
  final String emprNome;

  EmpresaBodyModel({required this.emprNome});

  Map<String, dynamic> toJson() => {'empr_nome': emprNome};
}
