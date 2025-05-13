import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/styles.dart';

class PersonsOnTask extends StatelessWidget {
  const PersonsOnTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Row(
              children: List.generate(3, (index) {
                return CircleAvatar(
                  radius: 14.w,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage(
                    "assets/images/test_person.jpg",
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.w,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  '27 April',
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 16.w,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  '2',
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
