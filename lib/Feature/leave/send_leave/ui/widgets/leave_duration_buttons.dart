// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
// import 'package:madarj/generated/l10n.dart';

// class LeaveDurationButtons extends StatelessWidget {
//   const LeaveDurationButtons({
//     super.key,
//     this.startDate,
//     this.endDate,
//     required this.controller,
//   });

//   final DateTime? startDate;
//   final DateTime? endDate;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: OutlinedButton(
//             onPressed: startDate != null && endDate != null
//                 ? () {
//                     // Get the cubit from context
//                     final cubit = context.read<SendLeaveCubit>();

//                     // Save the dates to cubit
//                     cubit.startDate = startDate;
//                     cubit.endDate = endDate;

//                     // Format dates properly for the controller
//                     // Using the format that matches your extension: "YYYY-MM-DDTHH:MM:SS.sssZ:YYYY-MM-DDTHH:MM:SS.sssZ"
//                     final formattedText =
//                         "${startDate!.toIso8601String()}Z:${endDate!.toIso8601String()}";

//                     // Update the controller text
//                     controller.text = formattedText;

//                     print(
//                       "Dates saved to cubit: ${cubit.startDate} to ${cubit.endDate}",
//                     );
//                     print("Controller text set to: ${controller.text}");

//                     Navigator.pop(context);
//                   }
//                 : null,
//             style: OutlinedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 50),
//               backgroundColor: startDate != null && endDate != null
//                   ? ColorsManager.mainColor1
//                   : Colors.grey.shade200,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//             ),
//             child: Text(
//               S.of(context).Submit_Date,
//               style: startDate != null && endDate != null
//                   ? TextStyles.font16WhiteSemiBold
//                   : TextStyles.font16BlackSemiBold.copyWith(color: Colors.grey),
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: OutlinedButton(
//             onPressed: () => Navigator.pop(context),
//             style: OutlinedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//             ),
//             child: Text(
//               S.of(context).close_button,
//               style: TextStyles.font16BlackSemiBold.copyWith(
//                 color: ColorsManager.mainColor1,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveDurationButtons extends StatelessWidget {
  const LeaveDurationButtons({
    super.key,
    this.startDate,
    this.endDate,
    required this.controller, // Add controller parameter
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final TextEditingController controller; // Add this

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: startDate != null && endDate != null
                ? () {
                    final cubit = context.read<SendLeaveCubit>();

                    print("on button ${cubit.startDate}:${cubit.endDate}");
                    cubit.changeDragDownHint(
                      controller,
                      "${cubit.startDate}:${cubit.endDate}",
                    );

                    Navigator.pop(context);
                  }
                : null, // Disable button if dates are not selected
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: startDate != null && endDate != null
                  ? ColorsManager.mainColor1
                  : Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              S.of(context).Submit_Date,
              style: startDate != null && endDate != null
                  ? TextStyles.font16WhiteSemiBold
                  : TextStyles.font16BlackSemiBold.copyWith(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 10), // Changed from height to width
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              S.of(context).close_button,
              style: TextStyles.font16BlackSemiBold.copyWith(
                color: ColorsManager.mainColor1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// // import 'package:flutter/material.dart';
// // import 'package:madarj/Core/themes/colors.dart';
// // import 'package:madarj/Core/themes/styles.dart';
// // import 'package:madarj/generated/l10n.dart';

// // class LeaveDurationButtons extends StatelessWidget {
// //   const LeaveDurationButtons({super.key, this.startDate, this.endDate, required this.controller});

// //   final DateTime? startDate;
// //   final DateTime? endDate;
// //   final TextEditingController controller; // Add this

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       children: [
// //         Expanded(
// //           child: OutlinedButton(
// //             onPressed: () {
// //               cubit.changeDragDownHint(
// //                 controller,
// //                 "${cubit.startDate}:${cubit.endDate}",
// //               );
// //               Navigator.pop(context);
// //             },
// //             style: OutlinedButton.styleFrom(
// //               minimumSize: const Size(double.infinity, 50),
// //               backgroundColor: startDate != null && endDate != null
// //                   ? ColorsManager.mainColor1
// //                   : Colors.transparent,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(25),
// //               ),
// //             ),
// //             child: Text(
// //               S.of(context).Submit_Date,
// //               style: startDate != null && endDate != null
// //                   ? TextStyles.font16WhiteSemiBold
// //                   : TextStyles.font16BlackSemiBold.copyWith(
// //                       color: ColorsManager.mainColor1,
// //                     ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 10),
// //         Expanded(
// //           child: OutlinedButton(
// //             onPressed: () => Navigator.pop(context),
// //             style: OutlinedButton.styleFrom(
// //               minimumSize: const Size(double.infinity, 50),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(25),
// //               ),
// //             ),
// //             child: Text(
// //               S.of(context).close_button,
// //               style: TextStyles.font16BlackSemiBold.copyWith(
// //                 color: ColorsManager.mainColor1,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
