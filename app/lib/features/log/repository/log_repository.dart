import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';

abstract class LogRepository {
  Future<Result<HealtModel>> healt();
}
