import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Feature/cards/ui/widgets/card_item_widget.dart';
import 'package:madarj/generated/l10n.dart';

class CardsGrid extends StatelessWidget {
  const CardsGrid({super.key});

  final List<String> images = const [
    'assets/images/cards/attendance.png',
    'assets/images/cards/expenses.png',
    'assets/images/cards/leaves [time off].png',
    'assets/images/cards/payroll.png',
    'assets/images/cards/leaves [time off].png',
  ];
  final List<String> svgs = const [
    'assets/svgs/attendanceicon.svg',
    'assets/svgs/expensesicon.svg',
    'assets/svgs/leavestimeouticon.svg',
    'assets/svgs/leavestimeouticon.svg',
    'assets/svgs/leavestimeouticon.svg',
  ];

  final List<String> screens = const [
    Routes.homeScreen,
    Routes.expenseScreen,
    Routes.leaveScreen,
    Routes.payroll,
    Routes.leaveManager,
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> texts = [
      S.of(context).Attendance,
      S.of(context).Expense,
      S.of(context).Leave,
      S.of(context).Payroll,
      S.of(context).Leave_manager,
    ];
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount:
            CachHelper.getData(key: SharedKeys.isTimeOff) != "manager"
                ? 4
                : images.length,
        itemBuilder: (context, index) {
          final hasRightBorder = index % 2 == 0;
          final hasBottomBorder = index < 2;
          return Container(
            decoration: BoxDecoration(
              border: Border(
                right:
                    hasRightBorder
                        ? const BorderSide(color: Colors.grey, width: 2)
                        : BorderSide.none,
                bottom:
                    hasBottomBorder
                        ? const BorderSide(color: Colors.grey, width: 2)
                        : BorderSide.none,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardItemWidget(
                image: images[index],
                title: texts[index],
                screen: screens[index],
                isManagent: index > 3,
              ),
            ),
          );
        },
      ),
    );
  }
}
