import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../data/model/empresa/empresa_usuario_model.dart';
import 'empresa_usuario_viewmodel.dart';

class EmpresaUsuarioView extends StatefulWidget {
  const EmpresaUsuarioView({super.key, required this.viewModel});

  final EmpresaUsuarioViewmodel viewModel;

  @override
  State<EmpresaUsuarioView> createState() => _EmpresaUsuarioViewState();
}

class _EmpresaUsuarioViewState extends State<EmpresaUsuarioView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getUsuariosCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant EmpresaUsuarioView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.getUsuariosCommand.removeListener(_onResult);
    widget.viewModel.getUsuariosCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.getUsuariosCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    final command = widget.viewModel.getUsuariosCommand;
    if (command.error) {
      String msgError = kDefaultAppError;

      final commandResult = command.result;
      if (commandResult case Error(error: final exception)) {
        if (exception is HandledException) {
          msgError = exception.message;
        } else if (exception is HttpServiceException) {
          msgError = exception.message ?? exception.toString();
        } else {
          msgError = exception.toString();
        }
      }

      DialogBottomSheetWarning(
        dialogWarning: DialogWarning(
          title: AppLocalizations.of(context).translate('error'),
          titleButtonPrimary: AppLocalizations.of(context).translate('ok'),
          titleButtonSecondary: AppLocalizations.of(context).translate('ok'),
          isDismissible: false,
          typeButtonsDialog: DialogBottomSheetTypeButtons.horizontalButtons,
          description: AppLocalizations.of(context).translate(msgError),
          statusDialog: DialogBottomSheetStatus.statusCritical,
          onPressedPrimary: () => context.pop(),
          onPressedSecondary: () => context.pop(),
        ),
      ).showModal(context);

      command.clearResult();
    } else if (command.completed) {
      command.clearResult();
    }
  }

  Widget _usuarioTile(EmpresaUsuarioModel usuario) {
    final title = usuario.udetNome?.trim().isNotEmpty == true ? usuario.udetNome! : usuario.usuaEmail;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person_outline)),
        title: Text(title),
        subtitle: Text([
          usuario.usuaEmail,
          if (usuario.udetUsuario?.trim().isNotEmpty == true) '@${usuario.udetUsuario}',
        ].join('\n')),
        isThreeLine: usuario.udetUsuario?.trim().isNotEmpty == true,
        trailing: Text('#${usuario.usuaId}'),
      ),
    );
  }

  Widget _screen() {
    final command = widget.viewModel.getUsuariosCommand;
    final usuarios = widget.viewModel.usuarios;

    return Scaffold(
      bottomNavigationBar: const ViewBottomActions(),
      appBar: AppBar(
        title: const Text('Usuários da empresa'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Atualizar usuários',
            onPressed: command.running ? null : command.execute,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: command.running && usuarios == null
          ? const Center(child: Loading())
          : usuarios == null
          ? Center(
              child: FilledButton.icon(
                onPressed: command.running ? null : command.execute,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            )
          : usuarios.isEmpty
          ? const Center(child: Text('Nenhum usuário vinculado à empresa.'))
          : Column(
              children: [
                if (command.running) const LinearProgressIndicator(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: command.execute,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: usuarios.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                      itemBuilder: (context, index) => _usuarioTile(usuarios[index]),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.viewModel, builder: (context, child) => _screen());
  }
}
