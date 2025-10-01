import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_body.dart';
import 'package:madarj/generated/l10n.dart';

class Payroll extends StatelessWidget {
  const Payroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightGray,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            context.pushNamed(Routes.cardsScreen);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined, size: 25.w),
        ),
        title: Text(
          S.of(context).Payroll_and_Tax,
          style: TextStyles.font16BlackSemiBold,
        ),
      ),
      body: const PayrollBody(),
    );
  }
}
