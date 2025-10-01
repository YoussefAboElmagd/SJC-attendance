import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_manager_body.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveManager extends StatelessWidget {
  const LeaveManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,
      body: Stack(
        children: [
          const LeaveManagerBody(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
            child: const HomeTopIcons(),
          ),
        ],
      ),
    );
  }
}

class BottomLeaveManagerButton extends StatelessWidget {
  const BottomLeaveManagerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
        child: InkWell(
          onTap: () {
            context.pushNamed(Routes.sendLeave);
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
                S.of(context).Submit_Leave_text,
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
