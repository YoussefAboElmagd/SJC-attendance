
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/upload_task_photos.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_cubit.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_state.dart';
import 'package:madarj/Feature/tasks/send_tasks/ui/widget/build_dropdown_tasks.dart';
import 'package:madarj/generated/l10n.dart';

class SendTasksForms extends StatelessWidget {
  const SendTasksForms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendTasksCubit, SendTasksState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            const UploadTaskPhotos(),
            const SizedBox(height: 16),
            BuildTextField(
              label: S.of(context).Task_Title,
              hint: S.of(context).Enter_Task_Title,
              icon: "assets/svgs/summary-expenses(3).svg",
            ),
            SizedBox(height: 16.h),
            BuildTextField(
              label: S.of(context).Task_Description,
              hint: S.of(context).Enter_Task_Description,
              icon: null,
              maxLines: 3,
            ),
            BuildDropdownTasks(
              label: S.of(context).Assign_To,
              icon: "assets/svgs/summary-expenses(1).svg",
              hint:
                  context.read<SendTasksCubit>().assignTo?.text.isEmpty ?? true
                      ? S.of(context).Select_Member
                      : context.read<SendTasksCubit>().assignTo!.text,
              items: const [
                "Ivankov - Sr Front End Developer",
                "Brahm - Mid Front End Developer",
                "Alice - Sr Front End Developer",
                "Jeane - Jr Front End Developer",
                "Claudia - Jr Front End Developer",
                "helmy - sr fotware enginner",
                "dolaa - sr fotware enginner",
                "3laa - sr fotware enginner",
                "bombo - sr fotware enginner",
              ],
              controller: context.read<SendTasksCubit>().assignTo,
            ),
            SizedBox(height: 16.h),
            BuildDropdownTasks(
              label: S.of(context).Priority,
              hint: context
                          .read<SendTasksCubit>()
                          .priorityControl
                          ?.text
                          .isEmpty ??
                      true
                  ? S.of(context).Select_Priority
                  : context.read<SendTasksCubit>().priorityControl!.text,
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "Low",
                "Medium",
                "High",
              ],
              controller: context.read<SendTasksCubit>().priorityControl,
            ),
            SizedBox(height: 16.h),
            BuildDropdownTasks(
              label: S.of(context).Tags,
              hint: context.read<SendTasksCubit>().tagsControl?.text.isEmpty ??
                      true
                  ? S.of(context).Select_tag
                  : context.read<SendTasksCubit>().tagsControl!.text,
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "Very Easy (Less Than a Day)",
                "Easy (A Day)",
                "Moderate (3 Days)",
                "Intermediate (5 Days)",
                "Advanced (1 Week)",
              ],
              controller: context.read<SendTasksCubit>().tagsControl,
            ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
}
