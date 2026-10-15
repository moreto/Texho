import 'package:commons/api_core.dart';
import 'package:commons/commons.dart';
import 'package:service/service.dart';

import '../../../data/model/notificacao_model.dart';
import 'notificacao_repository.dart';

class NotificacaoRepositoryImpl implements NotificacaoRepository {
  @override
  Future<Result<List<NotificacaoModel>>> getNotificacoes() async {
    try {
      final response = await DioProvider.of(ApiCore.notificacao).request(verb: Verb.get);
      switch (response) {
        case Ok(value: final value) when value is List:
          return Result.ok(
            value
                .map((item) {
                  if (item is! Map) {
                    throw const FormatException('Formato de notificação inválido.');
                  }
                  return NotificacaoModel.fromJson(Map<String, dynamic>.from(item));
                })
                .toList(growable: false),
          );
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(HandledException(message: 'Formato de resposta da API inválido.'));
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}
