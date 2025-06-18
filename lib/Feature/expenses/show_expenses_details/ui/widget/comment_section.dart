import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/widgets/app_text_formField.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14.w,
          backgroundColor: Colors.transparent,
          backgroundImage: const AssetImage("assets/images/test_person.jpg"),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: AppTextFormField(
            hintText: 'Write a comment...',
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsManager.mainColor1, width: 1.3.w),
              borderRadius: BorderRadius.circular(16.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.grey2, width: 1.3.w),
              borderRadius: BorderRadius.circular(16.r),
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send, size: 20.w),
            ),
          ),
        ),
      ],
    );
  }
}