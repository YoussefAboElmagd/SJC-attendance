import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_body.dart';
import 'package:madarj/generated/l10n.dart';

class Leave extends StatelessWidget {
  const Leave({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,
      body: const LeaveBody(),
    );
  }
}

class BottomLeaveButton extends StatelessWidget {
  const BottomLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
