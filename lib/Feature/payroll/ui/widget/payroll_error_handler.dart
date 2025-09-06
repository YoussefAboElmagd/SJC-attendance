import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_error_dialog.dart';
import 'package:madarj/generated/l10n.dart';

class PayrollErrorHandler extends StatelessWidget {
  final ApiErrorModel error;

  const PayrollErrorHandler({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleErrorState(context, error);
    });
    return const SizedBox.shrink();
  }

  void _handleErrorState(BuildContext context, ApiErrorModel error) async {
    final errorMessage = error.message ?? 'An unexpected error occurred';

    if (error.message == S.of(context).token_expired) {
      await _handleTokenExpiration(context);
    } else {
      showDialog(
        barrierDismissible: false,

        context: context,
        builder: (context) => PayrollErrorDialog(errorMessage: errorMessage),
      );
    }
  }

  Future<void> _handleTokenExpiration(BuildContext context) async {
    CachHelper.removeData(key: SharedKeys.userToken);
    CachHelper.clearAllSecuredData();
    AppConstants.isLogged = false;
    await CachHelper.saveData(key: SharedKeys.isLogged, value: false);
    DioFactory.setTokenAfterLogin(null);

    Fluttertoast.showToast(
      msg: 'Session expired. Please login again.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );

    context.pushNamedAndRemoveUntill(Routes.loginScreen);
  }
}
