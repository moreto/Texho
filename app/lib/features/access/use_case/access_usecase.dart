import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:commons/log.dart';
import 'package:commons/result.dart';

import '../repository/access_repository.dart';

class AccessUseCase {
  AccessUseCase({required this._accessRepository}) {
    Log.print(super.runtimeType);
  }

  final AccessRepository _accessRepository;

  Future<Result<AccessModel>> register(AccessBodyModel model) async {
    final serviceResult = await _accessRepository.register(model);
    switch (serviceResult) {
      case Ok<AccessModel>():
        return Result.ok(serviceResult.value);
      case Error<AccessModel>():
        return Result.error(serviceResult.error);
    }
  }
}
