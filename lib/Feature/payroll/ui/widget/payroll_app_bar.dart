import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class PayrollAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PayrollAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        onTap: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_new_outlined, size: 25.w),
      ),
      title: Text(
        S.of(context).Payroll_and_Tax,
        style: TextStyles.font16BlackSemiBold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
