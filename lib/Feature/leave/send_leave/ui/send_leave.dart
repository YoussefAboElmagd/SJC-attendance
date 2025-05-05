import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/send_leave_body.dart';
import 'package:madarj/generated/l10n.dart';

class SendLeave extends StatelessWidget {
  const SendLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.w,
          ),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).Submit_Leave,
          style: TextStyles.font20BlackSemiBold,
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<SendLeaveCubit>(),
        child: const SendLeaveBody(),
      ),
    );
  }
}
