import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_drop_down.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/ensure_claim.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/upload_claim_doc.dart';
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
                const UploadClaimDoc(),
                SizedBox(height: 20.h),
                BuildDropdown(
                  label: S.of(context).Expense_Category,
                  hint: S.of(context).Select_Category,
                  icon: "assets/svgs/summary-expenses(1).svg",
                  items: const [
                    "ssss2",
                    "ssss1",
                    "ssss3",
                    "ssss4",
                    "ssss5",
                    "ssss6",
                    "ssss7",
                    "ssss8",
                  ],
                ),
                SizedBox(height: 16.h),
                BuildDropdown(
                  label: S.of(context).Transaction_Date,
                  hint: S.of(context).Enter_Transaction_Date,
                  icon: "assets/svgs/summary-expenses(2).svg",
                  items: const [
                    "ssss2",
                    "ssss1",
                    "ssss3",
                    "ssss4",
                    "ssss5",
                    "ssss6",
                    "ssss7",
                    "ssss8",
                  ],
                ),
                SizedBox(height: 16.h),
                BuildTextField(
                  label: S.of(context).Expense_Amount,
                  hint: S.of(context).Enter_Amount,
                  icon: "assets/svgs/summary-expenses(3).svg",
                ),
                SizedBox(height: 16.h),
                BuildTextField(
                  label: S.of(context).Expense_Description,
                  hint: S.of(context).Enter_Expense_Description,
                  icon: null,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
