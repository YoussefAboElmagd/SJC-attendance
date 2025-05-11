import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/base/ui/views/base_layer.dart';
import 'package:madarj/Feature/home/ui/home.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (prevoius, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginError,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          loginLoading: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainColor,
                ),
              ),
            );
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return const CircularProgressIndicator(
            //         color: ColorsManager.mainColor,
            //       );
            //     });
          },
          loginSuccess: (loginResponse) async {
            context.pop();
            context.pushNamed(Routes.homeScreen, routerNavigator: false);
            // Navigator.of(context).pushAndRemoveUntil(
            //   MaterialPageRoute(
            //     builder: (_) => const BaseLayer(
            //       initialIndex: 0,
            //     ),
            //   ),
            //   (route) => false, // Remove ALL previous routes
            // );
            // Navigator.of(context).pushAndRemoveUntil(
            //   MaterialPageRoute(
            //     builder: (_) => const BaseLayer(),
            //   ),
            //   (route) => false, // Remove ALL previous routes
            // );

            // FocusScope.of(context).unfocus();
            // context.pushNamedAndRemoveUntill(
            //   Routes.homeScreen,
            //   predicate: (route) => false, // This removes ALL previous routes
            // );
            // context.pushNamedAndRemoveUntill(Routes.homeScreen);
            // print(loginResponse.userData.token);
            // await saveToken(loginResponse.userData.token ?? "");
          },
          loginError: (error) {
            context.pop();
            setUpErrorState(context, error);
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
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
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
              'Got it',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}

// saveToken(String token) async {
//   await CachHelper.setSecuredString(
//     value: token,
//     key: SharedKeys.userToken,
//   );
//   DioFactory.setTokenAfterLogin(token);
// }
