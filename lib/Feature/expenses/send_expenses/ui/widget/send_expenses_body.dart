import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
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

class CreateExpensesBlocListener extends StatelessWidget {
  const CreateExpensesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendExpensesCubit, SendExpensesState>(
      listenWhen: (prevoius, current) =>
          current is CreateExpensesLoading ||
          current is CreateExpensesSuccess ||
          current is CreateExpensesError,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          createExpensesLoading: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainColor,
                ),
              ),
            );
          },
          createExpensesSuccess: (response) async {
            context.pop();
            context.pushNamed(Routes.expenseScreen);
          },
          createExpensesError: (error) {
            context.pop();
            setUpErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          apiErrorModel.message!,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.popAlert();
            },
            child: Text(
              'Got it',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
