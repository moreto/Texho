import 'package:app/config/command.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../../data/model/empresa/empresa_body_model.dart';
import '../../../data/model/empresa/empresa_model.dart';
import '../use_case/empresa_usecase.dart';

class EmpresaViewmodel extends ChangeNotifier {
  EmpresaViewmodel({required this.empresaUseCase}) {
    Log.print(super.runtimeType);
  }

  final EmpresaUseCase empresaUseCase;

  late final Command0<EmpresaModel?> getEmpresaCommand = Command0(_getEmpresa);
  late final Command1<EmpresaModel, String> postEmpresaCommand = Command1(_postEmpresa);
  late final Command1<EmpresaModel, String> putEmpresaCommand = Command1(_putEmpresa);

  EmpresaModel? _empresaModel;
  EmpresaModel? get empresaModel => _empresaModel;

  Future<Result<EmpresaModel?>> _getEmpresa() async {
    notifyListeners();

    final result = await empresaUseCase.getEmpresa();
    switch (result) {
      case Ok<EmpresaModel?>():
        _empresaModel = result.value;
      case Error<EmpresaModel?>(error: final error):
        Log.print(error.toString(), name: kApp, title: 'Erro');
    }

    notifyListeners();
    return result;
  }

  Future<Result<EmpresaModel>> _postEmpresa(String nome) async {
    notifyListeners();

    final result = await empresaUseCase.postEmpresa(EmpresaBodyModel(emprNome: nome));
    switch (result) {
      case Ok<EmpresaModel>():
        _empresaModel = result.value;
      case Error<EmpresaModel>(error: final error):
        Log.print(error.toString(), name: kApp, title: 'Erro');
    }

    notifyListeners();
    return result;
  }

  Future<Result<EmpresaModel>> _putEmpresa(String nome) async {
    notifyListeners();

    final empresa = _empresaModel;
    if (empresa == null) {
      return Result.error(Exception('Não existe uma empresa carregada para edição.'));
    }

    final updatedEmpresa = EmpresaModel(emprId: empresa.emprId, emprUuid: empresa.emprUuid, emprNome: nome);
    final result = await empresaUseCase.putEmpresa(updatedEmpresa);
    switch (result) {
      case Ok<EmpresaModel>():
        _empresaModel = result.value;
      case Error<EmpresaModel>(error: final error):
        Log.print(error.toString(), name: kApp, title: 'Erro');
    }

    notifyListeners();
    return result;
  }
}
