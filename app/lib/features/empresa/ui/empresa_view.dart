import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import 'empresa_viewmodel.dart';

class EmpresaView extends StatefulWidget {
  const EmpresaView({super.key, required this.viewModel});

  final EmpresaViewmodel viewModel;

  @override
  State<EmpresaView> createState() => _EmpresaViewState();
}

class _EmpresaViewState extends State<EmpresaView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.empresaCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant EmpresaView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.empresaCommand.removeListener(_onResult);
    widget.viewModel.empresaCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.empresaCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (widget.viewModel.empresaCommand.error) {
      String msgError = kDefaultAppError;

      final commandResult = widget.viewModel.empresaCommand.result;
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

      widget.viewModel.empresaCommand.clearResult();
    } else if (widget.viewModel.empresaCommand.completed) {
      // widget.viewModel.statusCoreBankingCommand.clearResult();
      // redirect
    }
  }

  Widget _screen() {
    if (widget.viewModel.empresaCommand.running) {
      return Loading();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Empresa'), elevation: 0, centerTitle: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(child: Text('Empresa')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.viewModel, builder: (context, child) => _screen());
  }
}
