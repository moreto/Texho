import 'package:commons/commons.dart';

import '../../../data/model/access/access_body_model.dart';
import '../../../data/model/access/access_model.dart';

abstract class AccessRepository {
  Future<Result<AccessModel>> register(AccessBodyModel model);
  Future<Result<bool>> login(AccessBodyModel model);
}
