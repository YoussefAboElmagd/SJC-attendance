import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.screen,
    this.isManagent,
  });

  final String image;
  final String title;
  final String screen;
  final bool? isManagent;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(screen);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 100.h,
            width: 100.h,
            color: isManagent == true ? Colors.red : null,
          ),
          SizedBox(height: 10.h),
          Text(title, style: TextStyles.font16BlackSemiBold),
        ],
      ),
    );
  }
}
