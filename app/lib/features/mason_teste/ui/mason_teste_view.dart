import 'package:app/l10n/app_localizations.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'mason_teste_viewmodel.dart';

class MasonTesteView extends StatefulWidget {
  const MasonTesteView({super.key, required this.viewModel});

  final MasonTesteViewmodel viewModel;

  @override
  State<MasonTesteView> createState() => _MasonTesteViewState();
}

class _MasonTesteViewState extends State<MasonTesteView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.healtCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant MasonTesteView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.healtCommand.removeListener(_onResult);
    widget.viewModel.healtCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.healtCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (widget.viewModel.healtCommand.error) {
      String msgError = 'err';

      // final resultCommand = widget.viewModel.healtCommand.result;
      // if (resultCommand is Error) {
      //   final exception = resultCommand.error;
      //   msgError = exception is HttpServiceException ? exception.message ?? exception.toString() : exception.toString();
      // }

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).translate(msgError))));

      DialogBottomSheetWarning(
        dialogWarning: DialogWarning(
          title: 'Erro',
          titleButtonPrimary: 'Ok',
          titleButtonSecondary: 'Ok',
          isDismissible: false,
          typeButtonsDialog: DialogBottomSheetTypeButtons.horizontalButtons,
          description: AppLocalizations.of(context).translate(msgError),
          statusDialog: DialogBottomSheetStatus.statusCritical,
          onPressedPrimary: () => context.pop(),
          onPressedSecondary: () => context.pop(),
        ),
      ).showModal(context);

      widget.viewModel.healtCommand.clearResult();
    } else if (widget.viewModel.healtCommand.completed) {
      // widget.viewModel.statusCoreBankingCommand.clearResult();
      // redirect
    }
  }

  StatefulWidget _screen() {
    final strings = AppLocalizations.of(context);

    if (widget.viewModel.healtCommand.running) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(strings.translate('registro')), elevation: 0, centerTitle: true),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(strings.translate('registro'), style: Theme.of(context).textTheme.headlineLarge),
                Text(strings.translate('efetueRegistro'), style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.viewModel, builder: (context, child) => _screen());
  }
}
