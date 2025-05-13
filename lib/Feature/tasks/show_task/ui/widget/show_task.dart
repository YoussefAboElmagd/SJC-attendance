import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_text_formField.dart';
import 'package:madarj/Feature/tasks/show_task/logic/cubit/show_task_details_cubit.dart';
import 'package:madarj/Feature/tasks/show_task/logic/cubit/show_task_details_state.dart';
import 'package:madarj/generated/l10n.dart';

class ShowTaskDetails extends StatelessWidget {
  ShowTaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: TextStyles.font18BlackSemiBold,
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => getIt<ShowTaskDetailsCubit>(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey[100]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                25.r,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create On Boarding Screen',
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.mainColor1,
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                        child: Text(
                          S.of(context).In_Progress_text,
                          style: TextStyles.font14WhiteSemiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Created 27 Sept 2024',
                    style: TextStyles.font12lightBlackSemiBold,
                  ),
                  SizedBox(height: 16.h),
                  // ✅ الصورة الرئيسية
                  const TaskImages(),

                  // Center(
                  //   child: Image.asset(
                  //     'assets/images/task.jpg',
                  //     width: MediaQuery.sizeOf(context).width,
                  //     height: 180.h,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  // SizedBox(height: 8.h),
                  // SizedBox(
                  //   height: 60.h,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: imagePaths.length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(right: 8.w),
                  //         child: Image.asset(
                  //           imagePaths[index],
                  //           height: 60.h,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 16.h),
                  Text(
                    'Description',
                    style: TextStyles.font14BlackSemiBold,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Create on boarding page based on pic, pixel perfect, with the user story of i want to know what kind of apps is this so i need to view onboarding screen to leverage my knowledge so that i know what kind of apps is this',
                    style: TextStyles.font14GreySemiBold,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Priority',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorsManager.highRed,
                              borderRadius: BorderRadius.circular(
                                20.r,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 15.w,
                              ),
                              child: Text(
                                'High',
                                style: TextStyles.font14WhiteSemiBold,
                              ),
                            ),
                          )
                        ],
                      ),
                      // SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Difficulty',
                            style: TextStyles.font14BlackSemiBold,
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                            ),
                            child: Text(
                              'Very Easy (Less Than a Day)',
                              style: TextStyles.font14BlackSemiBold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assignee',
                        style: TextStyles.font14BlackSemiBold,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14.w,
                            backgroundColor: Colors.transparent,
                            backgroundImage: const AssetImage(
                              "assets/images/test_person.jpg",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alice',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                              Text(
                                'Sr Front End Developer',
                                style: TextStyles.font12lightBlackSemiBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14.w,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage(
                          "assets/images/test_person.jpg",
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: AppTextFormField(
                          hintText: 'Write a comment...',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsManager.mainColor1,
                              width: 1.3.w,
                            ),
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsManager.grey2,
                              width: 1.3.w,
                            ),
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send,
                              size: 20.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 14.w,
                  //       backgroundColor: Colors.transparent,
                  //       backgroundImage: const AssetImage(
                  //         "assets/images/test_person.jpg",
                  //       ),
                  //     ),
                  //     const AppTextFormField(
                  //       hintText: 'Write a comment...',
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskImages extends StatelessWidget {
  const TaskImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowTaskDetailsCubit, ShowTaskDetailsState>(
      builder: (context, state) {
        var cubit = context.read<ShowTaskDetailsCubit>();
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

            // ✅ قائمة الصور
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cubit.imagePaths.length,
                itemBuilder: (context, index) {
                  final imagePath = cubit.imagePaths[index];
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<ShowTaskDetailsCubit>()
                          .selectImage(imagePath);
                    },
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
                        child: Image.asset(
                          imagePath,
                          height: 60.h,
                        ),
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
