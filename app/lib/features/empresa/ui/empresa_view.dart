import 'package:app/config/command.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../data/model/empresa/empresa_model.dart';
import '../../../data/model/empresa/empresa_usuario_model.dart';
import 'empresa_usuario_viewmodel.dart';
import 'empresa_viewmodel.dart';

class EmpresaView extends StatefulWidget {
  const EmpresaView({super.key, required this.viewModel, required this.empresaUsuarioViewModel});

  final EmpresaViewmodel viewModel;
  final EmpresaUsuarioViewmodel empresaUsuarioViewModel;

  @override
  State<EmpresaView> createState() => _EmpresaViewState();
}

class _EmpresaViewState extends State<EmpresaView> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  late final TabController _tabController;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.viewModel.getEmpresaCommand.addListener(_onGetResult);
    widget.viewModel.postEmpresaCommand.addListener(_onPostResult);
    widget.viewModel.putEmpresaCommand.addListener(_onPutResult);
    widget.empresaUsuarioViewModel.getUsuariosCommand.addListener(_onUsuariosResult);
    // widget.viewModel.getEmpresaCommand.execute();
  }

  @override
  void didUpdateWidget(covariant EmpresaView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.getEmpresaCommand.removeListener(_onGetResult);
    oldWidget.viewModel.postEmpresaCommand.removeListener(_onPostResult);
    oldWidget.viewModel.putEmpresaCommand.removeListener(_onPutResult);
    oldWidget.empresaUsuarioViewModel.getUsuariosCommand.removeListener(_onUsuariosResult);
    widget.viewModel.getEmpresaCommand.addListener(_onGetResult);
    widget.viewModel.postEmpresaCommand.addListener(_onPostResult);
    widget.viewModel.putEmpresaCommand.addListener(_onPutResult);
    widget.empresaUsuarioViewModel.getUsuariosCommand.addListener(_onUsuariosResult);
  }

  @override
  void dispose() {
    widget.viewModel.getEmpresaCommand.removeListener(_onGetResult);
    widget.viewModel.postEmpresaCommand.removeListener(_onPostResult);
    widget.viewModel.putEmpresaCommand.removeListener(_onPutResult);
    widget.empresaUsuarioViewModel.getUsuariosCommand.removeListener(_onUsuariosResult);
    _tabController.dispose();
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

  void _onUsuariosResult() {
    final command = widget.empresaUsuarioViewModel.getUsuariosCommand;
    if (command.error) {
      _showCommandError(command);
    } else if (command.completed) {
      command.clearResult();
    }
  }

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

  Widget _buildEmpresaForm(EmpresaModel? empresa, bool isSaving) {
    final viewModel = widget.viewModel;
    return SafeArea(
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
                          'Código: ${empresa.emprCodigo}',
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
    );
  }

  Widget _buildUsuarios() {
    final viewModel = widget.empresaUsuarioViewModel;
    final usuarios = viewModel.usuarios;

    if (viewModel.getUsuariosCommand.running && usuarios == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (usuarios == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Não foi possível carregar os usuários da empresa.'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: viewModel.getUsuariosCommand.running ? null : viewModel.getUsuariosCommand.execute,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }
    if (usuarios.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Nenhum usuário vinculado à empresa.'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: viewModel.getUsuariosCommand.running ? null : viewModel.getUsuariosCommand.execute,
              icon: const Icon(Icons.refresh),
              label: const Text('Atualizar usuários'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (viewModel.getUsuariosCommand.running) const LinearProgressIndicator(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: viewModel.getUsuariosCommand.execute,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: usuarios.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) => _buildUsuario(usuarios[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsuario(EmpresaUsuarioModel usuario) {
    final title = usuario.udetNome?.trim().isNotEmpty == true ? usuario.udetNome! : usuario.usuaEmail;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person_outline)),
        title: Text(title),
        subtitle: Text(
          [usuario.usuaEmail, if (usuario.udetUsuario?.trim().isNotEmpty == true) '@${usuario.udetUsuario}'].join('\n'),
        ),
        isThreeLine: usuario.udetUsuario?.trim().isNotEmpty == true,
        trailing: Text('#${usuario.usuaId}'),
      ),
    );
  }

  Widget _screen() {
    final viewModel = widget.viewModel;
    final empresa = viewModel.empresaModel;
    final isSaving = viewModel.postEmpresaCommand.running || viewModel.putEmpresaCommand.running;

    if (viewModel.getEmpresaCommand.running && empresa == null) {
      return const Scaffold(
        body: Center(child: Loading()),
        bottomNavigationBar: ViewBottomActions(),
      );
    }

    return Scaffold(
      bottomNavigationBar: const ViewBottomActions(),
      appBar: AppBar(
        title: const Text('Empresa'),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Empresa', icon: Icon(Icons.business_outlined)),
            Tab(text: 'Usuários', icon: Icon(Icons.people_outline)),
          ],
        ),
        // leading: IconButton(tooltip: 'Voltar', onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            tooltip: 'Atualizar empresa',
            onPressed: viewModel.getEmpresaCommand.running ? null : viewModel.getEmpresaCommand.execute,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: TabBarView(controller: _tabController, children: [_buildEmpresaForm(empresa, isSaving), _buildUsuarios()]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.empresaUsuarioViewModel,
      builder: (context, child) =>
          ListenableBuilder(listenable: widget.viewModel, builder: (context, child) => _screen()),
    );
  }
}
