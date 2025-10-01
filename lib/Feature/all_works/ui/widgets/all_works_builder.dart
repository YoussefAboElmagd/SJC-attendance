import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_cubit.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_state.dart';
import 'package:madarj/Feature/all_works/ui/widgets/error_dialog.dart';
import 'package:madarj/Feature/all_works/ui/widgets/list_of_checks.dart';
import 'package:madarj/Feature/all_works/ui/widgets/list_of_checks_shimmer.dart';

class AllWorksBuilder extends StatelessWidget {
  const AllWorksBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllWorkCubit, AllWorkState>(
      buildWhen: (previous, current) =>
          current is GetAllUserMonthWorkLoading ||
          current is GetAllUserMonthWorkSuccess ||
          current is GetAllUserMonthWorkError,
      builder: (context, state) {
        return state.maybeWhen(
          getAllUserMonthWorkLoading: () => const ListOfChecksShimmer(),
          getAllUserMonthWorkSuccess: (data) =>
              ListOfChecks(workDayEntries: data),
          getAllUserMonthWorkError: (errorHandler) => ErrorDialog(
            message: errorHandler.message!,
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
