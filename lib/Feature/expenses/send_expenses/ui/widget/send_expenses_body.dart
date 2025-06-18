import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/create_expenses_blocListener.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/ensure_claim.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/expenses_forms.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/upload_task_photos.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:madarj/generated/l10n.dart';

class SendExpensesBody extends StatelessWidget {
  const SendExpensesBody({
    super.key,
    required this.requests,
    required this.categories,
    this.update,
    this.id,
    this.expenseDetail,
  });
  final RequestTypesModel requests;
  final SendExpCategResponse categories;
  final ExpenseDetailsResponse? expenseDetail;
  final bool? update;
  final int? id;
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
                ExpensesForms(
                  requests: requests,
                  categories: categories,
                  update: update,
                  expenseDetail: expenseDetail,
                ),
                const CreateExpensesBlocListener(),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
