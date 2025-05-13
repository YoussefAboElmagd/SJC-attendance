import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/widget/task_card.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 650.h),
      child: false
          ? const NoWorkToday()
          : ListView.separated(
              padding: EdgeInsets.zero,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return index == 9
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: 25.h,
                        ),
                        child: const TaskCard(),
                      )
                    : const TaskCard();
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: 10,
            ),
    );
  }
}
