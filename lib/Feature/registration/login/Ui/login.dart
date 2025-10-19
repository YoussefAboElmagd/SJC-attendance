import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'widgets/login_background.dart';
import 'widgets/login_logo.dart';
import 'widgets/login_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
  bool _obscurePassword = true;
  // @override
  // void dispose() {
  //   context.read<LoginCubit>().emailController.dispose();
  //   context.read<LoginCubit>().passwordController.dispose();
  //   super.dispose();
  // }
  // Future<void> _loadLastUser() async {
  //   // Wait for the cubit to be available
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<LoginCubit>().loadLastUserCredentials();
  //   });
  // }

  // @override
  // void initState() {
  //   _loadLastUser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: Stack(
          children: [
            const LoginBackground(),
            Column(
              children: [
                const LoginLogo(),
                Expanded(
                  child: LoginForm(
                    rememberMe: rememberMe,
                    obscurePassword: _obscurePassword,
                    onRememberMeChanged:
                        (val) => setState(() {
                          // print("val remember $val");
                          CachHelper.saveData(
                            value: val,
                            key: SharedKeys.isLogged,
                          );
                          rememberMe = val;
                        }),
                    onTogglePassword:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
