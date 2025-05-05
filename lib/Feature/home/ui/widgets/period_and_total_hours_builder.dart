import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';
import 'package:madarj/generated/l10n.dart';

class PeriodAndTotalHoursBuilder extends StatelessWidget {
  const PeriodAndTotalHoursBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is Loading || current is CombinedSuccess || current is Error,
      builder: (BuildContext context, state) {
        return state.maybeWhen(
          loading: () {
            return const Expanded(
              child: Column(
                children: [
                  ClockInShimmer(),
                  ListOfchecksShimmer(),
                ],
              ),
            );
          },
          combinedSuccess: (data, data2, data3, data4) {
            if (data4.attendanceState == "checked_in") {
              context.read<HomeCubit>().clockInText = S.of(context).Clock_Out;
            }
            if (data4.attendanceState == "checked_out") {
              context.read<HomeCubit>().clockInText = S.of(context).Clock_In;
            }
            // print(data3.isEmpty);
            return Expanded(
              child: Column(
                children: [
                  ClockIn(
                    payPeriodResponse: data,
                    totalHours: data2,
                    clockStatusResponse: data4,
                  ),
                  ListOfchecks(workDayEntries: data3),
                ],
              ),
            );
          },
          error: (errorHandler) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setUpErrorState(context, errorHandler);
            });
            return const SizedBox.shrink();
          },
          // error: (errorHandler) => AlertDialog(
          //   icon: Icon(
          //     Icons.error,
          //     color: Colors.red,
          //     size: 32.w,
          //   ),
          //   content: Text(
          //     errorHandler.message!,
          //     style: TextStyles.font15DarkBlueMedium,
          //   ),
          //   actions: [
          //     TextButton(
          //       onPressed: () {
          //         // Navigator.of(context).pop();
          //         context.pop();

          //         // context.read<HomeCubit>().getAllHome2();
          //         // context.read<HomeCubit>().getAllHome2();
          //         context.pushNamed(Routes.homeScreen);
          //       },
          //       child: Text(
          //         'Try again',
          //         style: TextStyles.font14BlueSemiBold,
          //       ),
          //     ),
          //   ],
          // ),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}

void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
  final isMultipleErrors =
      apiErrorModel.errors != null && apiErrorModel.errors!.isNotEmpty;

  final errorMessage = isMultipleErrors
      ? apiErrorModel.errors!.values.join('\n')
      : apiErrorModel.message ?? 'An unexpected error occurred';

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(
        Icons.error,
        color: Colors.red,
        size: 32.w,
      ),
      content: Text(
        errorMessage,
        style: TextStyles.font15DarkBlueMedium,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            'Got it',
            style: TextStyles.font14BlueSemiBold,
          ),
        ),
      ],
    ),
  );
}


// void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       icon:  Icon(
//         Icons.error,
//         color: Colors.red,
//         size: 32.w,
//       ),
//       content: Text(
//         apiErrorModel.message!,
//         style: TextStyles.font15DarkBlueMedium,
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             context.pop();
//           },
//           child: Text(
//             'Got it',
//             style: TextStyles.font14BlueSemiBold,
//           ),
//         ),
//       ],
//     ),
//   );
// }
