import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';

class ClockInAppBar extends StatelessWidget {
  final String title;

  const ClockInAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: _buildBackButton(
                context,
              ),
            ),
            Expanded(
              flex: 100,
              child: _buildTitle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 15.w,
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xFF2A3183),
            size: 20.w,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        title,
        style: TextStyles.font18BlackBold,
      ),
    );
  }
}
