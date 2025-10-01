// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
// import 'package:madarj/Feature/payroll/ui/widget/payslip_info_box.dart';
// import 'package:madarj/generated/l10n.dart';


// class PayslipHeaderInfo extends StatelessWidget {
//   final PayslipDetailsData payslipData;

//   const PayslipHeaderInfo({super.key, required this.payslipData});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: PayslipInfoBox(
//             title: S.of(context).Overtime,
//             value:
//                 "40:00 ${S.of(context).hrs}" ??
//                 // "_formatHours(payslipData.overtimeHours) ??"
//                 "0:00 ${S.of(context).hrs}",
//           ),
//         ),
//         SizedBox(width: 12.w),
//         Expanded(
//           child: PayslipInfoBox(
//             title: S.of(context).This_Pay_Period,
//             value:
//                 "40:00 ${S.of(context).hrs}" ??
//                 // " _formatHours(payslipData.payPeriodHours) ??"
//                 "0:00 ${S.of(context).hrs}",
//           ),
//         ),
//       ],
//     );
//   }

//   String? _formatHours(double? hours) {
//     if (hours == null) return null;
//     final totalMinutes = (hours * 60).round();
//     final hoursFormatted = totalMinutes ~/ 60;
//     final minutes = totalMinutes % 60;
//     return "${hoursFormatted.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} hrs";
//   }
// }