import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_cubit.dart';
import 'package:madarj/Feature/all_works/ui/widgets/all_month_works_body.dart';
import 'package:madarj/generated/l10n.dart';

class AllMonthWorks extends StatelessWidget {
  const AllMonthWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightGray,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          S.of(context).All_Month_work,
          style: TextStyles.font16BlackSemiBold,
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<AllWorkCubit>()..getAllMonthWork(),
        child: const AllMonthWorksBody(),
      ),
    );
  }
}
