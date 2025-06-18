import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.error, color: Colors.red, size: 32.w),
      content: Text(message, style: TextStyles.font15DarkBlueMedium),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text('Got it', style: TextStyles.font14BlueSemiBold),
        ),
      ],
    );
  }
}
