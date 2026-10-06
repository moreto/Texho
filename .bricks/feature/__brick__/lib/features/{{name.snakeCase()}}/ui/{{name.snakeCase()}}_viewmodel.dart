import 'package:app/config/command.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../use_case/{{name.snakeCase()}}_usecase.dart';

class {{name.pascalCase()}}Viewmodel extends ChangeNotifier {
  {{name.pascalCase()}}Viewmodel({required this.useCase}) {
    Log.print(super.runtimeType);
    healtCommand.execute();
  }

  final {{name.pascalCase()}}UseCase useCase;

  late final Command0<HealtModel> healtCommand = Command0(_healt);
  late HealtModel _healtModel;
  HealtModel get healtModel => _healtModel;

  Future<Result<HealtModel>> _healt() async {
    notifyListeners();

    final result = await useCase.healt();
    switch (result) {
      case Ok<HealtModel>():
        _healtModel = result.value;
      case Error<HealtModel>(error: final error):
        Log.print(error.toString(), name: 'Texho', title: 'Erro');
    }

    notifyListeners();
    return result;
  }
}
