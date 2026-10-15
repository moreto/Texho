import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';
import '../repository/log_repository.dart';

class LogUseCase {
  LogUseCase({required this.logRepository}) {
    Log.print(super.runtimeType);
  }

  final LogRepository logRepository;

  Future<Result<HealtModel>> healt() async {
    final result = await logRepository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }
}
