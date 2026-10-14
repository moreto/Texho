import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';

abstract class NotificacaoRepository {
  Future<Result<HealtModel>> healt();
}
