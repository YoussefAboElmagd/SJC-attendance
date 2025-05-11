import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/tasks/ui/widget/leave_details_number.dart';
import 'package:madarj/generated/l10n.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 90.h,
      child: Row(
        // todo.svg
        children: [
          Expanded(
            child: TasksDetailsNumber(
              image: 'assets/images/orange_circle.png',
              title: S.of(context).To_Do,
              price: "1",
              widget: Container(
                width: 20.w,
                height: 20.h,
                child: SvgPicture.asset(
                  'assets/svgs/todo.svg',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            //clock.svg

            child: TasksDetailsNumber(
              image: 'assets/images/orange_circle.png',
              title: S.of(context).In_Progress_text,
              price: "1",
              widget: Container(
                width: 17.w,
                height: 17.h,
                child: SvgPicture.asset(
                  'assets/svgs/clock.svg',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: TasksDetailsNumber(
              image: 'assets/svgs/okay.svg',
              title: S.of(context).Done_text,
              price: '15',
              widget: Container(
                width: 20.w,
                height: 20.h,
                child: SvgPicture.asset(
                  'assets/svgs/okay.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
