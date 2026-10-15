import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../data/model/notificacao_model.dart';
import 'notificacao_viewmodel.dart';

class NotificacaoView extends StatefulWidget {
  const NotificacaoView({super.key, required this.viewModel});

  final NotificacaoViewmodel viewModel;

  @override
  State<NotificacaoView> createState() => _NotificacaoViewState();
}

class _NotificacaoViewState extends State<NotificacaoView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getNotificacoesCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant NotificacaoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.getNotificacoesCommand.removeListener(_onResult);
    widget.viewModel.getNotificacoesCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.getNotificacoesCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    final command = widget.viewModel.getNotificacoesCommand;
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

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();
    final formattedDate = MaterialLocalizations.of(context).formatMediumDate(localDate);
    final formattedTime = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(localDate),
    );
    return '$formattedDate $formattedTime';
  }

  Widget _buildNotificacao(NotificacaoModel notificacao) {
    final title = notificacao.notiTexto?.trim().isNotEmpty == true
        ? notificacao.notiTexto!
        : 'Notificação ${notificacao.notiId}';
    final hasAssociatedLog = notificacao.logId != null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        leading: Icon(
          notificacao.notiTipo.toUpperCase() == 'ERROR' ? Icons.error_outline : Icons.notifications_outlined,
          color: notificacao.notiTipo.toUpperCase() == 'ERROR' ? Theme.of(context).colorScheme.error : null,
        ),
        title: Text(title),
        subtitle: Text('${notificacao.notiTipo} · ${_formatDate(notificacao.notiData)}'),
        children: [
          if (hasAssociatedLog)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Log associado #${notificacao.logId}', style: Theme.of(context).textTheme.titleSmall),
                    if (notificacao.logTipo != null) Text('Tipo: ${notificacao.logTipo}'),
                    if (notificacao.logTexto?.isNotEmpty == true) Text('Descrição: ${notificacao.logTexto}'),
                    if (notificacao.logInfo?.isNotEmpty == true) ...[
                      const SizedBox(height: 8),
                      SelectableText(notificacao.logInfo!),
                    ],
                  ],
                ),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(width: double.infinity, child: Text('Sem log associado.')),
            ),
        ],
      ),
    );
  }

  Widget _screen() {
    final command = widget.viewModel.getNotificacoesCommand;
    final notificacoes = widget.viewModel.notificacoes;

    if (command.running && notificacoes == null) {
      return const Scaffold(body: Center(child: Loading()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Atualizar notificações',
            onPressed: command.running ? null : command.execute,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: notificacoes == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Não foi possível carregar as notificações.'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: command.running ? null : command.execute,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ),
            )
          : notificacoes.isEmpty
          ? const Center(child: Text('Nenhuma notificação encontrada.'))
          : Column(
              children: [
                if (command.running) const LinearProgressIndicator(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: command.execute,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: notificacoes.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                      itemBuilder: (context, index) => _buildNotificacao(notificacoes[index]),
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
