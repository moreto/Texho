import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/routes.dart';
import 'register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.viewModel});

  final RegisterViewmodel viewModel;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController(text: 'mmoreto@gmail.com');
  final TextEditingController _password = TextEditingController(text: '123');

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.translate('registro')),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
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
                  controller: _email,
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
                      color: Theme.of(context).primaryColor,
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
                  controller: _password,
                  maxLength: 12,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text(strings.translate('Senha'), style: Theme.of(context).textTheme.bodyLarge),
                    hintText: strings.translate('Informe a Senha'),
                    prefixIcon: Icon(
                      // MdiIcons.formTextboxPassword,
                      Icons.password,
                      color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                  controller: _password,
                  maxLength: 12,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text(strings.translate('confirmeSenha'), style: Theme.of(context).textTheme.bodyLarge),
                    hintText: strings.translate('informeConfirmacaoSenha'),
                    prefixIcon: Icon(
                      // MdiIcons.formTextboxPassword,
                      Icons.password,
                      color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                          context.push(Routes.home);
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
