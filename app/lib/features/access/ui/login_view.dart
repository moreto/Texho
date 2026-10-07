import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/routes.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.viewModel});

  final LoginViewmodel viewModel;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.viewModel.loginCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LoginView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loginCommand.removeListener(_onResult);
    widget.viewModel.loginCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.loginCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (widget.viewModel.loginCommand.error) {
      String msgError = kDefaultAppError;

      final commandResult = widget.viewModel.loginCommand.result;
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

      widget.viewModel.loginCommand.clearResult();
    } else if (widget.viewModel.loginCommand.completed) {
      // widget.viewModel.statusCoreBankingCommand.clearResult();
      // redirect
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.translate('login')), elevation: 0, centerTitle: true),
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
                Text(strings.translate('login'), style: Theme.of(context).textTheme.headlineLarge),
                Text(strings.translate('efetueLogin'), style: Theme.of(context).textTheme.bodyLarge),
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
                    hintText: strings.translate('informeSenha'),
                    prefixIcon: Icon(
                      // MdiIcons.formTextboxPassword,
                      Icons.password,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            child: Text(
                              strings.translate('Esqueceu'),
                              // style: Theme.of(context).textTheme.displaySmall,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 24,
                      child: ElevatedButton(
                        onPressed: () {
                          // context.push(Routes.home);
                          widget.viewModel.loginCommand.execute();
                        },
                        child: Text(strings.translate('login')),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 24,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(Routes.registro);
                        },
                        child: Text(strings.translate('registro')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
