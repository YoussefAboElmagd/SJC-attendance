import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_cubit.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/attendance_manager_body.dart';
import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';

class AttendanceManager extends StatelessWidget {
  const AttendanceManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,

      body: BlocProvider(
        create: (context) {
          if (CachHelper.getData(key: SharedKeys.isTimeOff) == 'manager') {
            return getIt<AttendanceManagerCubit>()..getAllEditRequests(context);
          } else {
            return getIt<AttendanceManagerCubit>()
              ..getEmployeeEditRequests(context);
          }
        },
        child: Stack(
          children: [
            const AttendanceManagerBody(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
              child: const HomeTopIcons(),
            ),
          ],
        ),
      ),
    );
  }
}
