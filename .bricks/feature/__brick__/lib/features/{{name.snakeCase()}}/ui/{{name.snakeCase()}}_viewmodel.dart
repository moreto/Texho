import 'package:flutter/material.dart';

import '../use_case/{{name.snakeCase()}}_usecase.dart';

class {{name.pascalCase()}}Viewmodel extends ChangeNotifier {
  {{name.pascalCase()}}Viewmodel({required this.useCase});

  final {{name.pascalCase()}}UseCase useCase;
}
