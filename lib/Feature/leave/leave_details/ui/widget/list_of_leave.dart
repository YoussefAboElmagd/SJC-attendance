import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_log_card.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/no_leave_today.dart';

class ListOfLeave extends StatelessWidget {
  const ListOfLeave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 550.h),
      child: false
          ? const NoWorkToday()
          : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemBuilder: (context, index) {
                return index == 9
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: 25.h,
                        ),
                        child: const LeaveLogCard(),
                      )
                    : const LeaveLogCard();
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemCount: 10,
            ),
    );
  }
}


// class PendingExpenses extends StatelessWidget {
//   PendingExpenses({
//     super.key,
//   });

//   final List<bool> reqStatus = [
//     true,
//     false,
//     true,
//     false,
//     true,
//     false,
//     true,
//     false,
//     true,
//     false,
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: (MediaQuery.sizeOf(context).height - 320.h),
//       child: false
//           ? const NoLeaveToday()
//           : Container(
//               decoration: const BoxDecoration(),
//               child: ListView.separated(
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       const LeaveLogCard(
//                         pending: true,
//                       ),
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 15.h,
//                 ),
//                 itemCount: 10,
//               ),
//             ),
//     );
//   }
// }

// class NewExpenses extends StatelessWidget {
//   const NewExpenses({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: (MediaQuery.sizeOf(context).height - 320.h),
//       child: false
//           ? const NoLeaveToday()
//           : Container(
//               decoration: const BoxDecoration(),
//               child: ListView.separated(
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       const InkWell(
//                         child: LeaveLogCard(
//                           isNew: true,
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 15.h,
//                 ),
//                 itemCount: 10,
//               ),
//             ),
//     );
//   }
// }
