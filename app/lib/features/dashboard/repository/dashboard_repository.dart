import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';
import '../../../data/model/menu_model.dart';

abstract class DashboardRepository {
  Future<Result<HealtModel>> healt();
  Future<Result<MenuModel>> menu();
}
