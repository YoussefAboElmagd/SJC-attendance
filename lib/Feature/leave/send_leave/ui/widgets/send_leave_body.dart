import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FillLeave(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LeaveClaim(),
                    SizedBox(height: 20.h),
                    const SendLeaveForms(),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          );
        },
      ),
    );
  }
}
