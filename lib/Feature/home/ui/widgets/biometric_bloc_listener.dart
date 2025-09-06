import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/generated/l10n.dart';

class BiometricBlocListener extends StatelessWidget {
  const BiometricBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen:
          (previous, current) =>
              current is HomeAuthenticating ||
              current is HomeAuthenticationFailed ||
              current is AuthError ||
              current is HomeAuthenticated ||
              current is HomeAuthenticationLockedOut,
      listener: (context, state) {
        state.whenOrNull(
          authenticating: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.mainColor2,
                    ),
                  ),
            );
          },
          authenticationFailed: () {
            context.popAlert();
            _showErrorDialog(
              context,
              S.of(context).Authentication_Failed,
              S.of(context).Biometric_authentication_failed_Please_try_again,
            );
          },
          authError: (apiError) {
            context.popAlert();
            _showErrorDialog(
              context,
              S.of(context).Authentication_Failed,
              '${apiError.message}',
            );
          },
          lockedOut: () {
            context.popAlert();
            _showErrorDialog(
              context,
              S.of(context).Locked_Out,
              S.of(context).Too_many_failed_attempts_Try_again_later,
            );
          },
          authenticated: (v) {
            context.popAlert();
            context.read<HomeCubit>().checkUser(context);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      barrierDismissible: false,

      context: context,
      builder:
          (context) => AlertDialog(
            icon: Icon(Icons.error, color: Colors.red, size: 32.w),
            title: Text(title),
            content: Text(message, style: TextStyles.font15DarkBlueMedium),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
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
