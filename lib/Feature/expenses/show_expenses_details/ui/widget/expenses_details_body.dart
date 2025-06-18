import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
// import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/comment_section.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/description_section.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/expenses_images.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/header_section.dart';
// import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/user_section.dart';

class ShowExpensesDetailsBody extends StatelessWidget {
  const ShowExpensesDetailsBody({
    super.key,
    this.isApproved,
    this.rejected,
    this.pending,
    this.isNew,
    this.data,
  });

  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;
  final ExpenseDetailsResponse? data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[100]!, width: 1),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(
                isApproved: isApproved,
                rejected: rejected,
                pending: pending,
                isNew: isNew,
                data: data,
              ),
              SizedBox(height: 4.h),
              Text(
                data!.data!.date!.toFormattedDate2(
                  locale: CachHelper.getData(key: "app_lang") ?? "ar",
                ),
              ),
              // Text(
              //   'Created at ${data!.data!.date!.getDayName()} ${data!.data!.date!.getMonthName()} ${data!.data!.date!.getYear()}',
              //   style: TextStyles.font12lightBlackSemiBold,
              // ),
              SizedBox(height: 16.h),
              ExpensesImages(data: data),
              SizedBox(height: 16.h),
              DescriptionSection(data: data),
              // const UserSection(),
              // SizedBox(height: 20.h),
              // const CommentSection(),
            ],
          ),
        ),
      ),
    );
  }
}
