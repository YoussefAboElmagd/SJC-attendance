import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_cubit.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_state.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/widget/expenses_details_body.dart';
import 'package:madarj/generated/l10n.dart';

class ShowExpensesDetails extends StatelessWidget {
  const ShowExpensesDetails({
    super.key,
    this.isApproved,
    this.rejected,
    this.pending,
    this.isNew,
    this.id,
  });

  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;
  final int? id;
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
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) =>
            getIt<ExpensesDetailsCubit>()..getExpenseDetails(id ?? 0),
        child: ExpensesDetailsBuilder(
          isApproved: isApproved,
          rejected: rejected,
          pending: pending,
          isNew: isNew,
        ),
      ),
    );
  }
}

class ExpensesDetailsBuilder extends StatelessWidget {
  const ExpensesDetailsBuilder({
    super.key,
    required this.isApproved,
    required this.rejected,
    required this.pending,
    required this.isNew,
  });

  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesDetailsCubit, ExpensesDetailsState>(
      buildWhen: (previous, current) =>
          current is GetExpenseDetaailsLoading ||
          current is GetExpenseDetaailsSuccess ||
          current is GetExpenseDetaailsError,
      builder: (context, state) {
        return state.maybeWhen(
          getExpenseDetaailsloading: () {
            return const Center(child: CircularProgressIndicator());
          },
          getExpenseDetaailssuccess: (data) {
            return ShowExpensesDetailsBody(
              isApproved: isApproved,
              rejected: rejected,
              pending: pending,
              isNew: isNew,
              data: data,
            );
          },
          getExpenseDetaailserror: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setUpErrorState(context, error);
            });
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) async {
  final isMultipleErrors =
      apiErrorModel.errors != null && apiErrorModel.errors!.isNotEmpty;

  final errorMessage = isMultipleErrors
      ? apiErrorModel.errors!.values.join('\n')
      : apiErrorModel.message ?? 'An unexpected error occurred';
  if (apiErrorModel.message == S.of(context).token_expired) {
    CachHelper.removeData(key: SharedKeys.userToken);
    CachHelper.clearAllSecuredData();
    context.pushNamedAndRemoveUntill(Routes.loginScreen);
    AppConstants.isLogged = false;
    await CachHelper.saveData(key: SharedKeys.isLogged, value: false);
    DioFactory.setTokenAfterLogin(null);
    Fluttertoast.showToast(
      msg: apiErrorModel.message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    context.pushNamedAndRemoveUntill(Routes.loginScreen);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.error, color: Colors.red, size: 32.w),
          content: Text(errorMessage, style: TextStyles.font15DarkBlueMedium),
          actions: [
            TextButton(
              onPressed: apiErrorModel.message != S.of(context).token_expired
                  ? () {
                      context.pushNamed(Routes.cardsScreen);
                    }
                  : () async {
                      CachHelper.removeData(key: SharedKeys.userToken);
                      CachHelper.clearAllSecuredData();
                      context.pushNamedAndRemoveUntill(Routes.loginScreen);
                      AppConstants.isLogged = false;
                      await CachHelper.saveData(
                        key: SharedKeys.isLogged,
                        value: false,
                      );
                      DioFactory.setTokenAfterLogin(null);
                    },
              // onPressed: () {
              //   apiErrorModel.message != S.of(context).token_expired
              //       ? context.pop()
              //       : context.pushNamedAndRemoveUntill(Routes.loginScreen);
              // },
              child: Text(
                apiErrorModel.message != S.of(context).token_expired
                    ? S.of(context).close_it
                    : S.of(context).Login_button,
                style: TextStyles.font14BlueSemiBold,
              ),
            ),
          ],
        );
      },
    );
  }
  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     icon: Icon(Icons.error, color: Colors.red, size: 32.w),
  //     content: Text(errorMessage, style: TextStyles.font15DarkBlueMedium),
  //     actions: [
  //       TextButton(
  //         onPressed: () async {
  //           if (apiErrorModel.message !=
  //               S.of(context).token_expired) {
  //             context.popAlert();
  //             context.pop();
  //           } else {
  //             CachHelper.removeData(key: SharedKeys.userToken);
  //             CachHelper.clearAllSecuredData();
  //             context.pushNamedAndRemoveUntill(Routes.loginScreen);
  //             AppConstants.isLogged = false;
  //             await CachHelper.saveData(key: SharedKeys.isLogged, value: false);
  //             DioFactory.setTokenAfterLogin(null);
  //           }
  //         },
  //         child: Text(
  //           apiErrorModel.message != S.of(context).token_expired
  //               ? S.of(context).close_it
  //               : S.of(context).Login_button,
  //           style: TextStyles.font14BlueSemiBold,
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
