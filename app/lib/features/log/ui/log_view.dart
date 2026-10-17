import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../data/model/log_model.dart';
import 'log_viewmodel.dart';

class LogView extends StatefulWidget {
  const LogView({super.key, required this.viewModel});

  final LogViewmodel viewModel;

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getLogsCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LogView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.getLogsCommand.removeListener(_onResult);
    widget.viewModel.getLogsCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.getLogsCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    final command = widget.viewModel.getLogsCommand;
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

  Widget _buildLog(LogModel log) {
    final title = log.logTexto?.trim().isNotEmpty == true ? log.logTexto! : 'Log ${log.logId}';
    final details = log.logInfo;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        leading: Icon(
          log.logTipo?.toUpperCase() == 'ERROR' ? Icons.error_outline : Icons.info_outline,
          color: log.logTipo?.toUpperCase() == 'ERROR' ? Theme.of(context).colorScheme.error : null,
        ),
        title: Text(title),
        subtitle: Text('${log.logTipo ?? 'Log'} · ${_formatDate(log.logData)}'),
        children: [
          if (details?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(width: double.infinity, child: SelectableText(details!)),
            ),
        ],
      ),
    );
  }

  Widget _screen() {
    final command = widget.viewModel.getLogsCommand;
    final logs = widget.viewModel.logs;

    if (command.running && logs == null) {
      return const Scaffold(
        body: Center(child: Loading()),
        bottomNavigationBar: ViewBottomActions(),
      );
    }

    return Scaffold(
      bottomNavigationBar: const ViewBottomActions(),
      appBar: AppBar(
        title: const Text('Log'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Atualizar logs',
            onPressed: command.running ? null : command.execute,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: logs == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Não foi possível carregar os logs.'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: command.running ? null : command.execute,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ),
            )
          : logs.isEmpty
          ? const Center(child: Text('Nenhum log encontrado.'))
          : Column(
              children: [
                if (command.running) const LinearProgressIndicator(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: command.execute,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: logs.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                      itemBuilder: (context, index) => _buildLog(logs[index]),
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
