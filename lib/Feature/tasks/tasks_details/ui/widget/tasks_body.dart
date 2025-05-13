import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/tasks.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/widget/leave_body_widgets.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/widget/tasks_top_header.dart';

class TasksBody extends StatelessWidget {
  const TasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const TasksTopHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: const TasksBodyWidgets(),
            ),
          ],
        ),
        const BottomTasksButton(),
      ],
    );
  }
}
