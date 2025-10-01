import 'package:flutter/material.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/show_expenses_status.dart';
import 'package:madarj/generated/l10n.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.isApproved,
    required this.rejected,
    required this.pending,
    required this.isNew,
    this.data,
  });
  final ExpenseDetailsResponse? data;

  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(S.of(context).Submit_Date, style: TextStyles.font16BlackSemiBold),
        const Spacer(),
        if (isApproved == true)
          ShowExpensesStatus(
            isApproved: S.of(context).Approved_Text,
            color: ColorsManager.green,
          ),
        if (rejected == true)
          ShowExpensesStatus(
            isApproved: S.of(context).Rejected_text,
            color: ColorsManager.red,
          ),
        if (isNew == true)
          ShowExpensesStatus(
            isApproved: S.of(context).new_section_text,
            color: ColorsManager.blue,
          ),
        if (pending == true)
          ShowExpensesStatus(
            isApproved: S.of(context).Pending_section_text,
            color: ColorsManager.blue,
          ),
      ],
    );
  }
}
