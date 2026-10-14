import 'package:app/config/command.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../data/model/empresa/empresa_model.dart';
import 'empresa_viewmodel.dart';

class EmpresaView extends StatefulWidget {
  const EmpresaView({super.key, required this.viewModel});

  final EmpresaViewmodel viewModel;

  @override
  State<EmpresaView> createState() => _EmpresaViewState();
}

class _EmpresaViewState extends State<EmpresaView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getEmpresaCommand.addListener(_onGetResult);
    widget.viewModel.postEmpresaCommand.addListener(_onPostResult);
    widget.viewModel.putEmpresaCommand.addListener(_onPutResult);
    widget.viewModel.getEmpresaCommand.execute();
  }

  @override
  void didUpdateWidget(covariant EmpresaView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.getEmpresaCommand.removeListener(_onGetResult);
    oldWidget.viewModel.postEmpresaCommand.removeListener(_onPostResult);
    oldWidget.viewModel.putEmpresaCommand.removeListener(_onPutResult);
    widget.viewModel.getEmpresaCommand.addListener(_onGetResult);
    widget.viewModel.postEmpresaCommand.addListener(_onPostResult);
    widget.viewModel.putEmpresaCommand.addListener(_onPutResult);
  }

  @override
  void dispose() {
    widget.viewModel.getEmpresaCommand.removeListener(_onGetResult);
    widget.viewModel.postEmpresaCommand.removeListener(_onPostResult);
    widget.viewModel.putEmpresaCommand.removeListener(_onPutResult);
    _nomeController.dispose();
    super.dispose();
  }

  void _onGetResult() {
    final command = widget.viewModel.getEmpresaCommand;
    if (command.error) {
      _loadFailed = widget.viewModel.empresaModel == null;
      if (mounted) setState(() {});
      _showCommandError(command);
      return;
    }

    if (command.result case Ok<EmpresaModel?>(value: final empresa)) {
      _loadFailed = false;
      _nomeController.text = empresa?.emprNome ?? '';
      command.clearResult();
    }
  }

  void _onPostResult() => _onSaveResult(widget.viewModel.postEmpresaCommand, 'Empresa cadastrada com sucesso.');

  void _onPutResult() => _onSaveResult(widget.viewModel.putEmpresaCommand, 'Empresa atualizada com sucesso.');

  void _onSaveResult(Command command, String successMessage) {
    if (command.error) {
      _showCommandError(command);
      return;
    }

    if (command.result case Ok<EmpresaModel>(value: final empresa)) {
      _nomeController.text = empresa.emprNome;
      _loadFailed = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMessage)));
      command.clearResult();
    }
  }

  void _showCommandError(Command command) {
    var message = kDefaultAppError;
    if (command.result case Error(error: final exception)) {
      if (exception is HandledException) {
        message = exception.message;
      } else if (exception is HttpServiceException) {
        message = exception.message ?? exception.toString();
      } else {
        message = exception.toString();
      }
    }

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
  }

  void _save() {
    if (_loadFailed || widget.viewModel.getEmpresaCommand.running) return;
    if (!_formKey.currentState!.validate()) return;

    final nome = _nomeController.text.trim();
    if (widget.viewModel.empresaModel == null) {
      widget.viewModel.postEmpresaCommand.execute(nome);
    } else {
      widget.viewModel.putEmpresaCommand.execute(nome);
    }
  }

  Widget _screen() {
    final viewModel = widget.viewModel;
    final empresa = viewModel.empresaModel;
    final isSaving = viewModel.postEmpresaCommand.running || viewModel.putEmpresaCommand.running;

    if (viewModel.getEmpresaCommand.running && empresa == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresa'),
        elevation: 0,
        centerTitle: true,
        // automaticallyImplyActions: true,
        leading: IconButton(tooltip: 'Voltar', onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            tooltip: 'Atualizar empresa',
            onPressed: viewModel.getEmpresaCommand.running ? null : viewModel.getEmpresaCommand.execute,
            icon: const Icon(Icons.refresh),
          ),
        ],
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
                      children: [
                        Icon(
                          empresa == null ? Icons.business_outlined : Icons.business,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          empresa == null ? 'Cadastrar empresa' : 'Dados da empresa',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        if (empresa != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Código: ${empresa.emprId}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _nomeController,
                          maxLength: 120,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Nome da empresa',
                            prefixIcon: Icon(Icons.business_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe o nome da empresa.';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _save(),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: isSaving || _loadFailed || viewModel.getEmpresaCommand.running ? null : _save,
                          icon: isSaving
                              ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                              : Icon(empresa == null ? Icons.add : Icons.save_outlined),
                          label: Text(
                            isSaving
                                ? 'Salvando...'
                                : empresa == null
                                ? 'Cadastrar empresa'
                                : 'Salvar alterações',
                          ),
                        ),
                        if (empresa == null) ...[
                          const SizedBox(height: 12),
                          if (_loadFailed)
                            Text(
                              'Não foi possível consultar a empresa. Atualize os dados antes de cadastrar.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          else
                            Text(
                              'Nenhuma empresa cadastrada. Preencha o nome para criar uma.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
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
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.viewModel, builder: (context, child) => _screen());
  }
}
