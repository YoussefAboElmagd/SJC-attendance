import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_cubit.dart';
import 'package:madarj/Feature/tasks/send_tasks/ui/widget/send_tasks_body.dart';
import 'package:madarj/generated/l10n.dart';

class SendTasks extends StatelessWidget {
  const SendTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.w,
          ),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).Create_New_Task,
          style: TextStyles.font20BlackSemiBold,
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<SendTasksCubit>(),
        child: const SendTasksBody(),
      ),
      bottomNavigationBar: const BottomSendTaskButton(),
    );
  }
}

void showCreateTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          24,
        ),
      ),
    ),
    // isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        height: 330.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                ),
                height: 285.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Create New Task ",
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Double-check your task details to ensure everything is correct. Do you want to proceed?",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.font16BlackNormal,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(42, 49, 131, 1),
                                    Color.fromRGBO(42, 49, 131, 1),
                                    Color.fromRGBO(91, 46, 212, 1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).Create_Task_button,
                                  style: TextStyles.font16WhiteSemiBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorsManager.mainColor1,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "No, Let me check",
                                  style: TextStyles.font16MainColorSemiBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const CircleAvatar(
              radius: 32,
              backgroundColor: Color(0xFF2A3183),
              child: Icon(Icons.event_note, color: Colors.white, size: 30),
            ),
          ],
        ),
      );
    },
  );
}

class BottomSendTaskButton extends StatelessWidget {
  const BottomSendTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showCreateTaskBottomSheet(context);
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(91, 46, 212, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                S.of(context).Submit_Leave_button,
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
