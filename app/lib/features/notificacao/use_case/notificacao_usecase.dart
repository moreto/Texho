import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';
import '../repository/notificacao_repository.dart';

class NotificacaoUseCase {
  NotificacaoUseCase({required this.notificacaoRepository}) {
    Log.print(super.runtimeType);
  }

  final NotificacaoRepository notificacaoRepository;

  Future<Result<HealtModel>> healt() async {
    final result = await notificacaoRepository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }
}
