import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/ui/leave_screen.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_body_widgets.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_top_header.dart';

class LeaveBody extends StatelessWidget {
  const LeaveBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const LeaveTopHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                height: (MediaQuery.sizeOf(context).height - 250.h),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveBodyWidgets(),
                    // Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
        const BottomLeaveButton(),
      ],
    );
  }
}
