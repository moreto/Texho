import 'package:app/config/command.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../use_case/empresa_vinculo_usecase.dart';

class EmpresaVinculoViewmodel extends ChangeNotifier {
  EmpresaVinculoViewmodel({required this.useCase}) {
    Log.print(super.runtimeType);
  }

  final EmpresaVinculoUseCase useCase;

  late final Command1<void, String> vincularCommand = Command1(_vincular);

  Future<Result<void>> _vincular(String codigo) async {
    notifyListeners();
    final result = await useCase.vincular(codigo);
    if (result case Error<void>(error: final error)) {
      Log.print(error.toString(), name: kApp, title: 'Erro');
    }
    notifyListeners();
    return result;
  }
}
