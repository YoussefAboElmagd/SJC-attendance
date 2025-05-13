import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/ensure_claim.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/expenses_forms.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/upload_task_photos.dart';
// import 'package:madarj/Feature/expenses/send_expenses/ui/widget/upload_claim_doc.dart';
import 'package:madarj/generated/l10n.dart';

class SendExpensesBody extends StatelessWidget {
  const SendExpensesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EnsureClaim(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.of(context).Fill_Claim_Information,
                  style: TextStyles.font18BlackSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  S.of(context).Information_about_claim_details,
                  style: TextStyles.font14GreyRegular,
                ),
                SizedBox(height: 20.h),
                const UploadTaskPhotos(),
                SizedBox(height: 20.h),
                const ExpensesForms(),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
