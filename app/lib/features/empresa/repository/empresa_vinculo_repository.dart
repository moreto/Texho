import 'package:commons/commons.dart';

abstract class EmpresaVinculoRepository {
  Future<Result<void>> vincular(String codigo);
}
