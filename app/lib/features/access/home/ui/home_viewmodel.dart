import 'package:commons/log.dart';
import 'package:flutter/material.dart';

import '../use_case/home_usecase.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel({required this._homeUseCase}) {
    Log.print(super.runtimeType);
  }
  TextEditingController cepController = TextEditingController(text: '73252200');
  final HomeUseCase _homeUseCase;
}
