import 'package:flutter/material.dart';

import '../use_case/mason_base_usecase.dart';

class MasonBaseViewmodel extends ChangeNotifier {
  MasonBaseViewmodel({required this.useCase});

  final MasonBaseUseCase useCase;
}
