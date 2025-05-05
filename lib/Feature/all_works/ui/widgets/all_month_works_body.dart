import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/all_works/data/model/get_month_work_response.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_cubit.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_state.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:madarj/Core/themes/colors.dart';

class AllMonthWorksBody extends StatelessWidget {
  const AllMonthWorksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: AllWorksBuilder(),
    );
  }
}

class AllWorksBuilder extends StatelessWidget {
  const AllWorksBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllWorkCubit, AllWorkState>(
      buildWhen: (previous, current) =>
          current is GetAllUserMonthWorkLoading ||
          current is GetAllUserMonthWorkSuccess ||
          current is GetAllUserMonthWorkError,
      builder: (BuildContext context, state) {
        return state.maybeWhen(
          getAllUserMonthWorkLoading: () {
            return const ListOfchecksShimmer();
          },
          getAllUserMonthWorkSuccess: (data) {
            return ListOfchecks(
              workDayEntries: data,
            );
          },
          getAllUserMonthWorkError: (errorHandler) => AlertDialog(
            icon: Icon(
              Icons.error,
              color: Colors.red,
              size: 32.w,
            ),
            content: Text(
              errorHandler.message!,
              style: TextStyles.font15DarkBlueMedium,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Got it',
                  style: TextStyles.font14BlueSemiBold,
                ),
              ),
            ],
          ),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}

class ListOfchecksShimmer extends StatelessWidget {
  const ListOfchecksShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return const DailyLogCardShimmer();
      },
      separatorBuilder: (context, index) => SizedBox(height: 15.h),
      itemCount: 10,
    );
  }
}

class DailyLogCardShimmer extends StatelessWidget {
  const DailyLogCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date shimmer
              Container(
                width: 120.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 8.h),
              // Main content shimmer
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left column shimmer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.w,
                          height: 12.h,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 60.w,
                          height: 16.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    // Right column shimmer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100.w,
                          height: 12.h,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 120.w,
                          height: 16.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfchecks extends StatelessWidget {
  const ListOfchecks({
    super.key,
    required this.workDayEntries,
  });

  final List<WorkDayEntry> workDayEntries;

  @override
  Widget build(BuildContext context) {
    return workDayEntries.isEmpty
        // return true
        ? const NoMonthWork()
        : ListView.separated(
            itemBuilder: (context, index) {
              return index == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DailyLogCard(
                          workDayEntry: workDayEntries[index],
                        ),
                      ],
                    )
                  : DailyLogCard(
                      workDayEntry: workDayEntries[index],
                    );
            },
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemCount: workDayEntries.length,
          );
  }
}

class DailyLogCard extends StatelessWidget {
  final WorkDayEntry workDayEntry;

  const DailyLogCard({
    super.key,
    required this.workDayEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/calendar.svg"),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  workDayEntry.date!,
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Hours,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                            71,
                            84,
                            103,
                            1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        workDayEntry.workedHours!,
                        // hours,
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Clock_in_Out,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                            71,
                            84,
                            103,
                            1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${workDayEntry.checkIn ?? S.of(context).No_checkIn} - ${workDayEntry.checkOut ?? S.of(context).No_checkout}", // .replaceFirst("and", "\\"),
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoMonthWork extends StatelessWidget {
  const NoMonthWork({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25.r,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h,
                right: 5.w,
                left: 5.w,
              ),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    15.r,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 12.0.h,
                  // bottom: 5.0,
                  right: 12.0.w,
                  left: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).month_Working_Period_text,
                          style: TextStyles.font14BlackSemiBold,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          S.of(context).month_working_time_text,
                          style: TextStyles.font14CyranRegular.copyWith(
                            color: ColorsManager.gray,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50.h,
                        right: 50.w,
                        left: 50.w,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svgs/no_work_today.svg",
                          width: 200.w,
                          height: 120.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).No_work_entries_available_text,
                          style: TextStyles.font16BlackSemiBold,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 8.w,
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              S.of(context).have_any_month_working_text,
                              style: TextStyles.font12GreyRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
