import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../../config/command.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../routing/routes.dart';
import 'login_viewmodel.dart';

enum _LoginMode { password, otp }

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.viewModel});

  final LoginViewmodel viewModel;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _otpFieldKey = GlobalKey<FormFieldState<String>>();
  _LoginMode _mode = _LoginMode.password;
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _otpFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    widget.viewModel.loginCommand.addListener(_onLoginResult);
    widget.viewModel.requestOtpCommand.addListener(_onOtpRequestResult);
    widget.viewModel.verifyOtpCommand.addListener(_onOtpVerificationResult);
  }

  @override
  void didUpdateWidget(covariant LoginView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loginCommand.removeListener(_onLoginResult);
    oldWidget.viewModel.requestOtpCommand.removeListener(_onOtpRequestResult);
    oldWidget.viewModel.verifyOtpCommand.removeListener(_onOtpVerificationResult);
    widget.viewModel.loginCommand.addListener(_onLoginResult);
    widget.viewModel.requestOtpCommand.addListener(_onOtpRequestResult);
    widget.viewModel.verifyOtpCommand.addListener(_onOtpVerificationResult);
  }

  @override
  void dispose() {
    widget.viewModel.loginCommand.removeListener(_onLoginResult);
    widget.viewModel.requestOtpCommand.removeListener(_onOtpRequestResult);
    widget.viewModel.verifyOtpCommand.removeListener(_onOtpVerificationResult);
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    widget.viewModel.dispose();
    super.dispose();
  }

  void _onLoginResult() {
    _consumeResult(
      widget.viewModel.loginCommand,
      onSuccess: () {
        if (widget.viewModel.loginResult) context.go(Routes.dashboard);
      },
    );
  }

  void _onOtpRequestResult() {
    final command = widget.viewModel.requestOtpCommand;
    if (command.error) {
      _showError(command.result);
      command.clearResult();
    } else if (command.completed) {
      setState(() {
        _clearOtpFields();
      });
      _otpFocusNodes.first.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se o e-mail estiver cadastrado, você receberá um código em instantes.')),
      );
      command.clearResult();
    }
  }

  void _onOtpVerificationResult() {
    _consumeResult(widget.viewModel.verifyOtpCommand, onSuccess: () => context.go(Routes.dashboard));
  }

  void _consumeResult(Command<bool> command, {VoidCallback? onSuccess}) {
    if (command.error) {
      _showError(command.result);
      command.clearResult();
    } else if (command.completed) {
      command.clearResult();
      onSuccess?.call();
    }
  }

  void _showError(Result? result) {
    var message = kDefaultAppError;
    if (result case Error(error: final error)) {
      message = switch (error) {
        HandledException() => error.message,
        HttpServiceException() => error.message ?? error.toString(),
        _ => error.toString(),
      };
    }

    final strings = AppLocalizations.of(context);
    DialogBottomSheetWarning(
      dialogWarning: DialogWarning(
        title: strings.translate('error'),
        titleButtonPrimary: strings.translate('ok'),
        titleButtonSecondary: strings.translate('ok'),
        isDismissible: false,
        typeButtonsDialog: DialogBottomSheetTypeButtons.horizontalButtons,
        description: strings.translate(message),
        statusDialog: DialogBottomSheetStatus.statusCritical,
        onPressedPrimary: () => context.pop(),
        onPressedSecondary: () => context.pop(),
      ),
    ).showModal(context);
  }

  String? _validateEmail(String? value, AppLocalizations strings) {
    if (value == null || value.trim().isEmpty) {
      return strings.translate('informeEmail');
    }
    return null;
  }

  String? _validatePassword(String? value, AppLocalizations strings) {
    if (value == null || value.isEmpty) {
      return strings.translate('informeSenha');
    }
    return null;
  }

  String? _validateOtp(String? value, AppLocalizations strings) {
    if (value == null || !RegExp(r'^\d{6}$').hasMatch(value)) {
      return strings.translate('informeCodigo6Digitos');
    }
    return null;
  }

  void _switchToOtp() {
    widget.viewModel.resetOtpFlow();
    _clearOtpFields();
    setState(() => _mode = _LoginMode.otp);
  }

  void _switchToPassword() {
    widget.viewModel.resetOtpFlow();
    _clearOtpFields();
    setState(() => _mode = _LoginMode.password);
  }

  void _clearOtpFields() {
    for (final controller in _otpControllers) {
      controller.clear();
    }
    _otpFieldKey.currentState?.reset();
  }

  void _onOtpChanged(int index, String value, FormFieldState<String> field) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 1) {
      for (var i = index; i < _otpControllers.length; i++) {
        final digitIndex = i - index;
        _otpControllers[i].text = digitIndex < digits.length ? digits[digitIndex] : '';
      }
      final focusIndex = (index + digits.length).clamp(0, _otpFocusNodes.length - 1);
      _otpFocusNodes[focusIndex].requestFocus();
    } else {
      _otpControllers[index].text = digits;
      if (digits.isNotEmpty && index < _otpFocusNodes.length - 1) {
        _otpFocusNodes[index + 1].requestFocus();
      }
    }

    final code = _otpControllers.map((controller) => controller.text).join();
    widget.viewModel.otp.value = TextEditingValue(
      text: code,
      selection: TextSelection.collapsed(offset: code.length),
    );
    field.didChange(code);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final viewModel = widget.viewModel;

    return Scaffold(
      appBar: AppBar(title: Text(strings.translate('login')), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          _mode == _LoginMode.password ? Icons.lock_outline : Icons.mark_email_read_outlined,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _mode == _LoginMode.password ? strings.translate('login') : strings.translate('efetueLogin'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _mode == _LoginMode.password
                              ? strings.translate('efetueLogin')
                              : strings.translate(
                                  viewModel.otpRequested ? 'digiteCodigoEnviado' : 'enviaremosCodigoAcesso',
                                ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: viewModel.email,
                          enabled: _mode != _LoginMode.otp || !viewModel.otpRequested,
                          maxLength: 90,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.username, AutofillHints.email],
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: strings.translate('email'),
                            hintText: strings.translate('informeEmail'),
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: (value) => _validateEmail(value, strings),
                        ),
                        SizedBox(height: 16.0),
                        if (_mode == _LoginMode.password) ...[
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: viewModel.password,
                            obscureText: true,
                            maxLength: 12,
                            autofillHints: const [AutofillHints.password],
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: strings.translate('Senha'),
                              hintText: strings.translate('informeSenha'),
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                            validator: (value) => _validatePassword(value, strings),
                            onFieldSubmitted: (_) {
                              if (_formKey.currentState!.validate()) {
                                viewModel.loginCommand.execute();
                              }
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _switchToOtp,
                              child: Text(strings.translate('esqueceuSenhaCodigo')),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListenableBuilder(
                            listenable: viewModel,
                            builder: (context, _) => FilledButton(
                              onPressed: viewModel.loginCommand.running
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        viewModel.loginCommand.execute();
                                      }
                                    },
                              child: viewModel.loginCommand.running
                                  ? const CircularProgressIndicator()
                                  : Text(strings.translate('login')),
                            ),
                          ),
                        ] else ...[
                          if (viewModel.otpRequested) ...[
                            const SizedBox(height: 12),
                            FormField<String>(
                              key: _otpFieldKey,
                              initialValue: '',
                              validator: (value) => _validateOtp(value, strings),
                              builder: (field) => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(strings.translate('codigoAcesso')),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var i = 0; i < _otpControllers.length; i++)
                                        SizedBox(
                                          width: 44,
                                          child: Semantics(
                                            label: '${strings.translate('codigoAcesso')} ${i + 1} de 6',
                                            child: TextField(
                                              controller: _otpControllers[i],
                                              focusNode: _otpFocusNodes[i],
                                              keyboardType: TextInputType.number,
                                              textInputAction: i == _otpControllers.length - 1
                                                  ? TextInputAction.done
                                                  : TextInputAction.next,
                                              autofillHints: i == 0 ? const [AutofillHints.oneTimeCode] : null,
                                              textAlign: TextAlign.center,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                                              ),
                                              onChanged: (value) => _onOtpChanged(i, value, field),
                                              onSubmitted: (_) {
                                                if (i < _otpFocusNodes.length - 1) {
                                                  _otpFocusNodes[i + 1].requestFocus();
                                                } else if (_formKey.currentState!.validate()) {
                                                  viewModel.verifyOtpCommand.execute();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (field.errorText != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      field.errorText!,
                                      style: Theme.of(context).textTheme.bodySmall
                                          ?.copyWith(color: Theme.of(context).colorScheme.error),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            ListenableBuilder(
                              listenable: viewModel,
                              builder: (context, _) => FilledButton(
                                onPressed: viewModel.verifyOtpCommand.running
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          viewModel.verifyOtpCommand.execute();
                                        }
                                      },
                                child: viewModel.verifyOtpCommand.running
                                    ? const CircularProgressIndicator()
                                    : Text(strings.translate('login')),
                              ),
                            ),
                            TextButton(
                              onPressed: viewModel.requestOtpCommand.running
                                  ? null
                                  : viewModel.requestOtpCommand.execute,
                              child: Text(strings.translate('Reenviar código')),
                            ),
                          ] else ...[
                            ListenableBuilder(
                              listenable: viewModel,
                              builder: (context, _) => FilledButton(
                                onPressed: viewModel.requestOtpCommand.running
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          viewModel.requestOtpCommand.execute();
                                        }
                                      },
                                child: viewModel.requestOtpCommand.running
                                    ? const CircularProgressIndicator()
                                    : Text(strings.translate('Enviar código')),
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          TextButton(onPressed: _switchToPassword, child: Text(strings.translate('voltarEntraSenha'))),
                        ],
                        const Divider(height: 32),
                        OutlinedButton(
                          onPressed: () => context.push(Routes.registro),
                          child: Text(strings.translate('criarConta')),
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
  }
}
