import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class PayrollErrorDialog extends StatelessWidget {
  final String errorMessage;

  const PayrollErrorDialog({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.error, color: Colors.red, size: 32.w),
      content: Text(errorMessage, style: TextStyles.font15DarkBlueMedium),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            S.of(context).close_it,
            style: TextStyles.font14BlueSemiBold,
          ),
        ),
      ],
    );
  }
}
