import 'package:app/config/command.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../../data/model/empresa/empresa_usuario_model.dart';
import '../use_case/empresa_usuario_usecase.dart';

class EmpresaUsuarioViewmodel extends ChangeNotifier {
  EmpresaUsuarioViewmodel({required this.empresaUsuarioUseCase}) {
    Log.print(super.runtimeType);
    getUsuariosCommand.execute();
  }

  final EmpresaUsuarioUseCase empresaUsuarioUseCase;

  late final Command0<List<EmpresaUsuarioModel>> getUsuariosCommand = Command0(_getUsuarios);
  List<EmpresaUsuarioModel>? _usuarios;
  List<EmpresaUsuarioModel>? get usuarios => _usuarios;

  Future<Result<List<EmpresaUsuarioModel>>> _getUsuarios() async {
    notifyListeners();

    final result = await empresaUsuarioUseCase.getUsuarios();
    switch (result) {
      case Ok<List<EmpresaUsuarioModel>>():
        _usuarios = result.value;
      case Error<List<EmpresaUsuarioModel>>(error: final error):
        Log.print(error.toString(), name: kApp, title: 'Erro');
    }

    notifyListeners();
    return result;
  }
}
