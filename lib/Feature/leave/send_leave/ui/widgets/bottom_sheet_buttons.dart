import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/widgets/app_button.dart';

class BottomSheetButtons extends StatelessWidget {
  final bool hasSelection;
  final VoidCallback onClose;
  final VoidCallback onSubmit;
  final String? buttonText;
  final String? buttonText2;

  const BottomSheetButtons({
    super.key,
    required this.hasSelection,
    required this.onClose,
    required this.onSubmit,
    this.buttonText,
    this.buttonText2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppTextButton(
            hintText: S.of(context).Close_Message,
            buttonText: buttonText2 ?? S.of(context).Close_Message,
            textStyle: TextStyles.font16GreyNormal,
            borderRadius: 30.r,
            onPressed: onClose,
            backgroundColor: ColorsManager.white,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: AppTextButton(
            hintText: S.of(context).Submit_Date,
            buttonText: buttonText ?? S.of(context).Submit_Date,
            textStyle: hasSelection
                ? TextStyles.font16WhiteSemiBold
                : TextStyles.font16WhiteNormal,
            onPressed: () {
              // print(buttonText);
              if (hasSelection) {
                context.pop();
              }
            },
            backgroundColor: hasSelection
                ? ColorsManager.mainColor1
                : ColorsManager.grey,
            borderRadius: 30.r,
          ),
        ),
      ],
    );
  }
}
