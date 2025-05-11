import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/tasks/ui/widget/list_of_leave.dart';
// import 'package:madarj/Feature/leave/leave_details/ui/widget/list_of_leave.dart';
import 'package:madarj/generated/l10n.dart';

class TotalTasks extends StatelessWidget {
  const TotalTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15.r,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Summary_of_Your_Work,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    S.of(context).current_task_progress,
                    style: TextStyles.font14BlackSemiBold.copyWith(
                      color: const Color.fromRGBO(
                        71,
                        84,
                        103,
                        1,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const ListOfTasks(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
