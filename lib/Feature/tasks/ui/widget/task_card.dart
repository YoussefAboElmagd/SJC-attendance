import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/tasks/ui/widget/persons_on_task.dart';
import 'package:madarj/Feature/tasks/ui/widget/status_chips.dart';
import 'package:madarj/Feature/tasks/ui/widget/task_progress_indicator.dart';
import 'package:madarj/Feature/tasks/ui/widget/top_task_card.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTaskCard(),
              SizedBox(height: 12.h),

              // Status chips
              const StatusChips(),
              SizedBox(
                height: 12.h,
              ),

              const TaskProgressIndicator(),
              SizedBox(
                height: 12.h,
              ),

              const PersonsOnTask()
            ],
          ),
        ),
      ),
    );
  }
}
