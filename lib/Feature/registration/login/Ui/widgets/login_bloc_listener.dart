import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/custom_snack_bar.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_state.dart';
import 'package:madarj/generated/l10n.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen:
          (prevoius, current) =>
              current is LoginLoading ||
              current is LoginSuccess ||
              current is LoginError,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          loginLoading: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.mainColor,
                    ),
                  ),
            );
          },
          loginSuccess: (loginResponse) async {
            
            context.pop();
            context.pushNamed(Routes.cardsScreen, routerNavigator: false);
            
          },
          loginError: (error) {
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(customSnackBar(message: error.message!));
            // setUpErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 32),
            content: Text(
              apiErrorModel.message!,
              style: TextStyles.font15DarkBlueMedium,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.popAlert();
                },
                child: Text(
                  S.of(context).close_it,
                  style: TextStyles.font14BlueSemiBold,
                ),
              ),
            ],
          ),
    );
  }
}
