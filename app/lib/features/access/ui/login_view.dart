import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  final TextEditingController _email = TextEditingController(
    text: 'mmoreto@gmail.com',
  );
  final TextEditingController _password = TextEditingController(text: '112233');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                Text('Login', style: Theme.of(context).textTheme.headlineLarge),
                Text(
                  'Efetue o Login',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _email,
                  maxLength: 90,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    counterText: '',
                    label: Text(
                      'eMail',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    hintText: 'Informe o eMail',
                    prefixIcon: Icon(
                      // MdiIcons.emailOutline,
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o eMail';
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
                    label: Text(
                      'Senha',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    hintText: 'Informe a Senha',
                    prefixIcon: Icon(
                      // MdiIcons.formTextboxPassword,
                      Icons.password,
                      color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                              'Esqueceu',
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
                      return 'Informe a Senha';
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
                        child: Text('LOGIN'),
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
