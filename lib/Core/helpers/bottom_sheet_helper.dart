import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';

Future<T?> showReusableBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  required String title,
  bool isDismissible = true,
  bool enableDrag = true,
  double? height,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: height ?? 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.5,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              spacing: 28.h,
              children: [
                Text(title, style: TextStyles.font16BlackSemiBold),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
