import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/bottom_sheet_helper.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/lang_enum.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/custom_button.dart';

void openLanguageSheet(BuildContext context) {
  final cubit = context.read<ApplicationCubit>();
  showReusableBottomSheet<LangEnum>(
    context: context,
    title: context.s.Language_text,
    height: 0.3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...LangEnum.values.map((lang) {
          return LanguageOptionButton(
            lang: lang,
            isSelected: cubit.lang == lang.name,
          );
        }),
      ],
    ),
  ).then((value) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (value != null) {
      cubit.getLanguage(value);
    }
  });
}

class LanguageOptionButton extends StatelessWidget {
  final LangEnum lang;
  final bool isSelected;

  const LanguageOptionButton({
    super.key,
    required this.lang,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      // padding: EdgeInsets.symmetric(vertical: 12.h),
      // fillColor: isSelected ? AppColors.primaryColor : AppColors.white,
      // borderColor: isSelected
      //     ? AppColors.transparent
      //     : AppColors.secondaryColor,
      textStyle:
          isSelected
              ? TextStyles.font14WhiteNormal
              : TextStyles.font14MainColorBold,
      color: isSelected ? ColorsManager.mainColor1 : ColorsManager.white,
      title: lang.displayName(context),
      onTap: isSelected ? null : () => context.pop(result: lang),
    );
  }
}
