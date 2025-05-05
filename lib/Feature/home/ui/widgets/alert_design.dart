import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';

class AlertDesign extends StatelessWidget {
  const AlertDesign({
    super.key,
    required this.content,
  });
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: content,
    );
  }
}
