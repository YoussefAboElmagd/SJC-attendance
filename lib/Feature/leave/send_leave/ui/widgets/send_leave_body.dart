import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/fill_leave.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/leave_claim.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/send_leave_forms.dart';

class SendLeaveBody extends StatelessWidget {
  const SendLeaveBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<SendLeaveCubit, SendLeaveState>(
        buildWhen: (previous, current) =>
            current is TimeoffTypesLoading ||
            current is TimeoffTypesSuccess ||
            current is TimeoffTypesError,

        builder: (context, state) {
          return state.maybeWhen(
            timeoffTypesLoading: () {
              return const Center(child: CircularProgressIndicator());
            },
            timeoffTypesSuccess: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FillLeave(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const LeaveClaim(),
                        SizedBox(height: 20.h),
                        SendLeaveForms(timeoffTypesResponse: data),
                        const SendLeaveListener(),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              );
            },
            timeoffTypesError: (err) {
              return const SizedBox();
            },
            orElse: () {
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}

class SendLeaveListener extends StatelessWidget {
  const SendLeaveListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendLeaveCubit, SendLeaveState>(
      listener: (BuildContext context, state) {
        state.whenOrNull(
          // orElse: () {},
          submitLeaveRequestError: (e) {
            context.popAlert();
            setUpErrorState(context, e);
          },
          submitLeaveRequestLoading: () {
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
          submitLeaveRequestSuccess: (e) {
            context.popAlert();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('succesfully send Leave'),
                backgroundColor: Colors.green,
              ),
            );
            context.pushNamedAndRemoveUntill(Routes.leaveScreen);
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
        icon: const Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(
          apiErrorModel.message!,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.popAlert();
            },
            child: Text('Got it', style: TextStyles.font14BlueSemiBold),
          ),
        ],
      ),
    );
  }
}
