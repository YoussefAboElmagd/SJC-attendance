import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Core/widgets/arrow_back.dart';
import 'package:madarj/generated/l10n.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 25.w,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          // const CustomArrowBack(),
          const SizedBox(height: 15),
          Center(
            child: Text(
              S.of(context).Language_text,
              style: TextStyles.font24BlackBold,
            ),
          ),
        ],
      ),
    );
  }
}
