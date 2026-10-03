import 'package:commons/result.dart';
import 'package:components/components/dialog/dialog_bottom_sheet_warning/dialog_bottom_sheet_warning.dart';
import 'package:components/components/dialog/dialog_bottom_sheet_warning/dialog_bottom_sheet_warning_status.dart';
import 'package:components/components/dialog/dialog_bottom_sheet_warning/dialog_bottom_sheet_warning_type_buttons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/api/service_exception.dart';

import '../../../l10n/app_localizations.dart';
import 'register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.viewModel});

  final RegisterViewmodel viewModel;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.viewModel.registerCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant RegisterView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.registerCommand.removeListener(_onResult);
    widget.viewModel.registerCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.registerCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (widget.viewModel.registerCommand.error) {
      String msgError = 'err';

      final resultCommand = widget.viewModel.registerCommand.result;
      if (resultCommand is Error) {
        final exception = resultCommand.error;
        msgError = exception is HttpServiceException ? exception.message ?? exception.toString() : exception.toString();
      }

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

      widget.viewModel.registerCommand.clearResult();
    } else if (widget.viewModel.registerCommand.completed) {
      // widget.viewModel.statusCoreBankingCommand.clearResult();
      // redirect
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.translate('registro')), elevation: 0, centerTitle: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(strings.translate('registro'), style: Theme.of(context).textTheme.headlineLarge),
                Text(strings.translate('efetueRegistro'), style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                TextFormField(
                  controller: widget.viewModel.email,
                  maxLength: 90,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    counterText: '',
                    label: Text(strings.translate('email'), style: Theme.of(context).textTheme.bodyLarge),
                    hintText: strings.translate('informeEmail'),
                    prefixIcon: Icon(
                      // MdiIcons.emailOutline,
                      Icons.email,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return strings.translate('Informe o eMail');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  controller: widget.viewModel.password,
                  maxLength: 12,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text(strings.translate('Senha'), style: Theme.of(context).textTheme.bodyLarge),
                    hintText: strings.translate('Informe a Senha'),
                    prefixIcon: Icon(
                      // MdiIcons.formTextboxPassword,
                      Icons.password,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            child: Icon(
                              // MdiIcons.eye,
                              Icons.remove_red_eye_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              // Get.toNamed(Routes.esqueceu);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return strings.translate('Informe a Senha');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  controller: widget.viewModel.confirmPassword,
                  maxLength: 12,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text(strings.translate('confirmeSenha'), style: Theme.of(context).textTheme.bodyLarge),
                    hintText: strings.translate('informeConfirmacaoSenha'),
                    prefixIcon: Icon(
                      // MdiIcons.formTextboxPassword,
                      Icons.password,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            child: Icon(
                              // MdiIcons.eye,
                              Icons.remove_red_eye_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              // Get.toNamed(Routes.esqueceu);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return strings.translate('informeConfirmacaoSenha');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 24,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.viewModel.registerCommand.execute();
                        },
                        child: Text(strings.translate('registro')),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
