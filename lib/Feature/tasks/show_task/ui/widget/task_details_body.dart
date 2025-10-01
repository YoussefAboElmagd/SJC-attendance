import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/tasks/show_task/ui/widget/comment_box.dart';
import 'package:madarj/Feature/tasks/show_task/ui/widget/priority_and_difficulty.dart';
import 'package:madarj/Feature/tasks/show_task/ui/widget/task_assignee.dart';
import 'package:madarj/Feature/tasks/show_task/ui/widget/task_creation_date.dart';
import 'package:madarj/Feature/tasks/show_task/ui/widget/task_header.dart';
import 'package:madarj/Feature/tasks/show_task/ui/widget/task_images.dart';

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[100]!, width: 1),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskHeader(),
              SizedBox(height: 4),
              TaskCreationDate(),
              SizedBox(height: 16),
              TaskImages(),
              SizedBox(height: 16),
              TaskDescription(),
              SizedBox(height: 16),
              PriorityAndDifficulty(),
              SizedBox(height: 16),
              TaskAssignee(),
              SizedBox(height: 16),
              CommentBox(),
            ],
          ),
        ),
      ),
    );
  }
}
