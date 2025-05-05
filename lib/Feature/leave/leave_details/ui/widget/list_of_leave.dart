import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_details_number.dart';
import 'package:madarj/generated/l10n.dart';

class ListOLeave extends StatelessWidget {
  const ListOLeave({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          Expanded(
            child: LeaveDetailsNumber(
              image: 'assets/images/orange_circle.png',
              title: S.of(context).Available_text,
              price: "1",
              widget: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: LeaveDetailsNumber(
              image: 'assets/images/orange_circle.png',
              title: S.of(context).Leave_Used,
              price: '15',
              widget: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: ColorsManager.mainColor1,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
