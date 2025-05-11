import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/generated/l10n.dart';

class SelectUploadClaimFile extends StatelessWidget {
  const SelectUploadClaimFile({super.key, required this.cubit});
  final SendExpensesCubit cubit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).select_file_type),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: Text(S.of(context).image_text),
            onTap: () async {
              Navigator.pop(context);
              await cubit.checkAndPickFile(
                context,
                cubit,
                FileType.image,
                cubit.pickImage,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(S.of(context).pdf_document),
            onTap: () async {
              Navigator.pop(context);
              await cubit.checkAndPickFile(
                context,
                cubit,
                FileType.custom,
                cubit.pickPdf,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(S.of(context).word_document),
            onTap: () async {
              Navigator.pop(context);
              await cubit.checkAndPickFile(
                context,
                cubit,
                FileType.custom,
                cubit.pickWordDocument,
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          AppTextButton(
            buttonText: S.of(context).close_button,
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () {
              context.popAlert();
            },
            backgroundColor: ColorsManager.mainColor1,
            hintText: "hintText",
          )
        ],
      ),
    );
  }
}
