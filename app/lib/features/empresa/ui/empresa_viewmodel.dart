import 'package:app/config/command.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../../data/model/empresa/empresa_body_model.dart';
import '../use_case/empresa_usecase.dart';

class EmpresaViewmodel extends ChangeNotifier {
  EmpresaViewmodel({required this.empresaUseCase}) {
    Log.print(super.runtimeType);
    empresaCommand.execute();
  }

  final EmpresaUseCase empresaUseCase;

  late final Command0<EmpresaModel> empresaCommand = Command0(_empresa);
  late EmpresaModel _empresaModel;
  EmpresaModel get empresaModel => _empresaModel;

  Future<Result<EmpresaModel>> _empresa() async {
    notifyListeners();

    final result = await empresaUseCase.getEmpresa();
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
