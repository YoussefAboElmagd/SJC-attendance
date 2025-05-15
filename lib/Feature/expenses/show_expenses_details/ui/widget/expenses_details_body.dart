import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_text_formField.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_cubit.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_state.dart';
import 'package:madarj/generated/l10n.dart';

class ShowExpensesDetailsBody extends StatelessWidget {
  const ShowExpensesDetailsBody({
    super.key,
    this.isApproved,
    this.rejected,
    this.pending,
    this.isNew,
  });
  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    'EXpense title',
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  const Spacer(),
                  isApproved == true
                      ? ShowExpensesStatus(
                          isApproved: S.of(context).Approved_Text,
                          color: ColorsManager.green,
                        )
                      : Container(),
                  rejected == true
                      ? ShowExpensesStatus(
                          isApproved: S.of(context).Rejected_text,
                          color: ColorsManager.red,
                        )
                      : Container(),
                  isNew == true
                      ? ShowExpensesStatus(
                          isApproved: S.of(context).new_section_text,
                          color: ColorsManager.blue,
                        )
                      : Container(),
                  pending == true
                      ? ShowExpensesStatus(
                          isApproved: S.of(context).Pending_section_text,
                          color: ColorsManager.blue,
                        )
                      : Container(),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                'Created 27 Sept 2024',
                style: TextStyles.font12lightBlackSemiBold,
              ),
              SizedBox(height: 16.h),
              const ExpensesImages(),
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
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By',
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
              SizedBox(height: 20.h),
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
            ],
          ),
        ),
      ),
    );
  }
}

class ShowExpensesStatus extends StatelessWidget {
  const ShowExpensesStatus({
    super.key,
    required this.isApproved,
    this.color,
  });

  final String? isApproved;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Text(
        isApproved!,
        style: TextStyles.font16WhiteSemiBold,
      ),
    );
  }
}

class ExpensesImages extends StatelessWidget {
  const ExpensesImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesDetailsCubit, ExpensesDetailsState>(
      builder: (context, state) {
        var cubit = context.read<ExpensesDetailsCubit>();
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
                          .read<ExpensesDetailsCubit>()
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
