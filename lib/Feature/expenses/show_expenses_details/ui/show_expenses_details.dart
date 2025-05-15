import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_cubit.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/expenses_details_body.dart';
import 'package:madarj/generated/l10n.dart';

class ShowExpensesDetails extends StatelessWidget {
  const ShowExpensesDetails({
    super.key,
    this.isApproved,
    this.rejected,
    this.pending,
    this.isNew,
  });

  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,
      appBar: AppBar(
        title: Text(
          S.of(context).Expenses_Details,
          style: TextStyles.font18BlackSemiBold,
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => getIt<ExpensesDetailsCubit>(),
        child: ShowExpensesDetailsBody(
          isApproved: isApproved,
          rejected: rejected,
          pending: pending,
          isNew: isNew,
        ),
      ),
    );
  }
}
