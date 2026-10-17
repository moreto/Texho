import 'package:app/features/empresa/use_case/empresa_usuario_usecase.dart';
import 'package:go_router/go_router.dart';

import '../../config/dependencies.dart';
import '../../features/empresa/repository/empresa_repository.dart';
import '../../features/empresa/repository/empresa_vinculo_repository.dart';
import '../../features/empresa/repository/empresa_usuario_repository.dart';
import '../../features/empresa/ui/empresa_usuario_view.dart';
import '../../features/empresa/ui/empresa_vinculo_viewmodel.dart';
import '../../features/empresa/ui/empresa_usuario_viewmodel.dart';
import '../../features/empresa/ui/empresa_view.dart';
import '../../features/empresa/ui/empresa_viewmodel.dart';
import '../../features/empresa/use_case/empresa_usecase.dart';
import '../../features/empresa/use_case/empresa_vinculo_usecase.dart';
import '../routes.dart';

class EmpresaRouter {
  static Set<GoRoute> get routes => {
    GoRoute(
      path: Routes.empresa,
      builder: (context, state) {
        final viewModel = EmpresaViewmodel(
          empresaUseCase: EmpresaUseCase(empresaRepository: locator<EmpresaRepository>()),
        );
        final empresaUsuarioViewModel = EmpresaUsuarioViewmodel(
          empresaUsuarioUseCase: EmpresaUsuarioUseCase(empresaUsuarioRepository: locator<EmpresaUsuarioRepository>()),
        );
        return EmpresaView(viewModel: viewModel, empresaUsuarioViewModel: empresaUsuarioViewModel);
      },
    ),

    GoRoute(
      path: Routes.empresaUsuario,
      builder: (context, state) {
        final viewModel = EmpresaVinculoViewmodel(
          useCase: EmpresaVinculoUseCase(repository: locator<EmpresaVinculoRepository>()),
        );
        return EmpresaUsuarioView(viewModel: viewModel);
      },
    ),
  };
}
