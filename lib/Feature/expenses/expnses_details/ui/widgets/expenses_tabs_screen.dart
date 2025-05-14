import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/list_of_expenses.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/build_tap.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_log_card.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/list_of_leave.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/no_leave_today.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesTabsScreen extends StatefulWidget {
  const ExpensesTabsScreen({super.key});

  @override
  State<ExpensesTabsScreen> createState() => _ExpensesTabsScreenState();
}

class _ExpensesTabsScreenState extends State<ExpensesTabsScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const NewExpenses(),
    const PendingExpenses(),
    DoneExpenses(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(25.r),
              left: Radius.circular(25.r),
            ),
          ),
          child: Row(
            children: [
              BuildTap(
                title: S.of(context).new_section_text,
                isSelected: selectedIndex == 0,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              BuildTap(
                title: S.of(context).Pending_section_text,
                isSelected: selectedIndex == 1,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              BuildTap(
                title: S.of(context).done_section_text,
                isSelected: selectedIndex == 2,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 2),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        screens[selectedIndex], // العرض حسب المؤشر
      ],
    );
  }
}

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

// class DoneExpenses extends StatelessWidget {
//   DoneExpenses({
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
//                       InkWell(
//                         child: LeaveLogCard(
//                           isApproved: reqStatus[index],
//                           rejected: !reqStatus[index],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 15.h,
//                 ),
//                 itemCount: reqStatus.length,
//               ),
//             ),
//     );
//   }
// }
