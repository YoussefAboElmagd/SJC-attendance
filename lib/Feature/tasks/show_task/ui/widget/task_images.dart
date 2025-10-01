import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/tasks/show_task/logic/cubit/show_task_details_cubit.dart';
import 'package:madarj/Feature/tasks/show_task/logic/cubit/show_task_details_state.dart';

class TaskImages extends StatelessWidget {
  const TaskImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowTaskDetailsCubit, ShowTaskDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ShowTaskDetailsCubit>();
        return Column(
          children: [
            Center(
              child: Image.asset(
                cubit.imageSelected ?? cubit.imagePaths[0],
                width: MediaQuery.sizeOf(context).width,
                height: 200.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cubit.imagePaths.length,
                itemBuilder: (context, index) {
                  final imagePath = cubit.imagePaths[index];
                  return GestureDetector(
                    onTap: () => cubit.selectImage(imagePath),
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: imagePath == cubit.imageSelected
                                ? ColorsManager.mainColor1
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(imagePath, height: 60.h),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
