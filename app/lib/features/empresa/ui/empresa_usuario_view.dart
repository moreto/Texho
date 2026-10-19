import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import 'empresa_vinculo_viewmodel.dart';

class EmpresaUsuarioView extends StatefulWidget {
  const EmpresaUsuarioView({super.key, required this.viewModel});

  final EmpresaVinculoViewmodel viewModel;

  @override
  State<EmpresaUsuarioView> createState() => _EmpresaUsuarioViewState();
}

class _EmpresaUsuarioViewState extends State<EmpresaUsuarioView> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.vincularCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant EmpresaUsuarioView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.vincularCommand.removeListener(_onResult);
    widget.viewModel.vincularCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.vincularCommand.removeListener(_onResult);
    _codigoController.dispose();
    super.dispose();
  }

  void _onResult() {
    final command = widget.viewModel.vincularCommand;
    if (command.error) {
      final result = command.result;
      final exception = result is Error ? result.error : null;
      final message = switch (exception) {
        HandledException() => exception.message,
        HttpServiceException() => exception.message ?? exception.toString(),
        _ => exception?.toString() ?? kDefaultAppError,
      };

      DialogBottomSheetWarning(
        dialogWarning: DialogWarning(
          title: AppLocalizations.of(context).translate('error'),
          titleButtonPrimary: AppLocalizations.of(context).translate('ok'),
          titleButtonSecondary: AppLocalizations.of(context).translate('ok'),
          isDismissible: false,
          typeButtonsDialog: DialogBottomSheetTypeButtons.horizontalButtons,
          description: AppLocalizations.of(context).translate(message),
          statusDialog: DialogBottomSheetStatus.statusCritical,
          onPressedPrimary: () => context.pop(),
          onPressedSecondary: () => context.pop(),
        ),
      ).showModal(context);
      command.clearResult();
    } else if (command.completed) {
      _codigoController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).translate('vinculoRealizado'))),
      );
      command.clearResult();
    }
  }

  void _vincular() {
    if (widget.viewModel.vincularCommand.running || !_formKey.currentState!.validate()) return;
    widget.viewModel.vincularCommand.execute(_codigoController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final strings = AppLocalizations.of(context);
        final command = widget.viewModel.vincularCommand;

        return Scaffold(
          bottomNavigationBar: ViewBottomActions(
            backLabel: strings.translate('voltar'),
            hideActionsTooltip: strings.translate('ocultarAcoes'),
            showActionsTooltip: strings.translate('exibirAcoes'),
          ),
          appBar: AppBar(
            title: Text(strings.translate('vincularEmpresa')),
            elevation: 0,
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.business_outlined, size: 48, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 16),
                            Text(
                              strings.translate('vinculeContaEmpresa'),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              strings.translate('informeCodigoVinculo'),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _codigoController,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.done,
                              enabled: !command.running,
                              decoration: InputDecoration(
                                labelText: strings.translate('codigoEmpresa'),
                                prefixIcon: Icon(Icons.key_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return strings.translate('informeCodigoEmpresa');
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _vincular(),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: command.running ? null : _vincular,
                              icon: command.running
                                  ? const SizedBox.square(
                                      dimension: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Icons.link),
                              label: Text(
                                strings.translate(command.running ? 'vinculando' : 'vincular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
