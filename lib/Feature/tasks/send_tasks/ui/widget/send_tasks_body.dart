
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_cubit.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_state.dart';
import 'package:madarj/Feature/tasks/send_tasks/ui/widget/send_tasks_forms.dart';

class SendTasksBody extends StatelessWidget {
  const SendTasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<SendTasksCubit, SendTasksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SendTasksForms(),
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
