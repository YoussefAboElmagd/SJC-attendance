import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Feature/cards/ui/widgets/card_item_widget.dart';
import 'package:madarj/generated/l10n.dart';

class CardsGrid extends StatelessWidget {
  const CardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final String? attendancePermission = CachHelper.getData(
      key: SharedKeys.isAttendance,
    );
    final String? timeOffPermission = CachHelper.getData(
      key: SharedKeys.isTimeOff,
    );

    List<CardData> availableCards = _getAvailableCards(
      context,
      attendancePermission,
      timeOffPermission,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: availableCards.length,
      itemBuilder: (context, index) {
        final card = availableCards[index];
        final hasRightBorder = index % 2 == 0;
        final hasBottomBorder = index < availableCards.length - 2;

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
              image: card.image,
              title: card.title,
              screen: card.screen,
              isManagent: card.isManager,
            ),
          ),
        );
      },
    );
  }

  List<CardData> _getAvailableCards(
    BuildContext context,
    String? attendancePermission,
    String? timeOffPermission,
  ) {
    List<CardData> cards = [];

    cards.addAll([
      CardData(
        image: 'assets/images/cards/expenses.png',
        svg: 'assets/svgs/expensesicon.svg',
        title: S.of(context).Expense,
        screen: Routes.expenseScreen,
        isManager: false,
      ),
      CardData(
        image: 'assets/images/cards/payroll.png',
        svg: 'assets/svgs/leavestimeouticon.svg',
        title: S.of(context).Payroll,
        screen: Routes.payroll,
        isManager: false,
      ),
    ]);

    if (attendancePermission != null &&
        (attendancePermission == 'user' || attendancePermission == 'manager')) {
      cards.insert(
        0,
        CardData(
          image: 'assets/images/cards/attendance.png',
          svg: 'assets/svgs/attendanceicon.svg',
          title: S.of(context).Attendance,
          screen: Routes.homeScreen,
          isManager: false,
        ),
      );
    }

    if (timeOffPermission != null &&
        (timeOffPermission == 'user' || timeOffPermission == 'manager')) {
      cards.insert(
        2,
        CardData(
          image: 'assets/images/cards/leaves [time off].png',
          svg: 'assets/svgs/leavestimeouticon.svg',
          title: S.of(context).Leave,
          screen: Routes.leaveScreen,
          isManager: false,
        ),
      );
    }

    if (timeOffPermission == 'manager') {
      cards.add(
        CardData(
          image: 'assets/images/cards/leaves [time off].png',
          svg: 'assets/svgs/leavestimeouticon.svg',
          title: S.of(context).Leave_manager,
          screen: Routes.leaveManager,
          isManager: true,
        ),
      );
    }

    if (timeOffPermission != null &&
        (timeOffPermission == 'user' || timeOffPermission == 'manager')) {
      cards.add(
        CardData(
          image: 'assets/images/cards/attendance.png',
          svg: 'assets/svgs/attendanceicon.svg',
          title: '${S.of(context).attendance_managment}',
          screen: Routes.attendanceManager,
          isManager: true,
        ),
      );
    }

    return cards;
  }
}

class CardData {
  final String image;
  final String svg;
  final String title;
  final String screen;
  final bool isManager;

  CardData({
    required this.image,
    required this.svg,
    required this.title,
    required this.screen,
    required this.isManager,
  });
}

// import 'package:flutter/material.dart';
// import 'package:madarj/Core/helpers/cach_helper.dart';
// import 'package:madarj/Core/helpers/shared_key.dart';
// import 'package:madarj/Core/routing/routes.dart';
// import 'package:madarj/Feature/cards/ui/widgets/card_item_widget.dart';
// import 'package:madarj/generated/l10n.dart';

// class CardsGrid extends StatelessWidget {
//   const CardsGrid({super.key});

//   final List<String> images = const [
//     'assets/images/cards/attendance.png',
//     'assets/images/cards/expenses.png',
//     'assets/images/cards/leaves [time off].png',
//     'assets/images/cards/payroll.png',
//     'assets/images/cards/leaves [time off].png',
//     'assets/images/cards/leaves [time off].png',
//   ];
//   final List<String> svgs = const [
//     'assets/svgs/attendanceicon.svg',
//     'assets/svgs/expensesicon.svg',
//     'assets/svgs/leavestimeouticon.svg',
//     'assets/svgs/leavestimeouticon.svg',
//     'assets/svgs/leavestimeouticon.svg',
//     'assets/svgs/leavestimeouticon.svg',
//   ];

//   final List<String> screens = const [
//     Routes.homeScreen,
//     Routes.expenseScreen,
//     Routes.leaveScreen,
//     Routes.payroll,
//     Routes.leaveManager,
//     Routes.leaveManager,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final List<String> texts = [
//       S.of(context).Attendance,
//       S.of(context).Expense,
//       S.of(context).Leave,
//       S.of(context).Payroll,
//       S.of(context).Leave_manager,
//       S.of(context).Leave_manager,
//     ];
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemCount:
//           CachHelper.getData(key: SharedKeys.isTimeOff) != "manager"
//               ? 4
//               : images.length,
//       itemBuilder: (context, index) {
//         final hasRightBorder = index % 2 == 0;
//         final hasBottomBorder = index < 2;
//         return Container(
//           decoration: BoxDecoration(
//             border: Border(
//               right:
//                   hasRightBorder
//                       ? const BorderSide(color: Colors.grey, width: 2)
//                       : BorderSide.none,
//               bottom:
//                   hasBottomBorder
//                       ? const BorderSide(color: Colors.grey, width: 2)
//                       : BorderSide.none,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CardItemWidget(
//               image: images[index],
//               title: texts[index],
//               screen: screens[index],
//               isManagent: index > 3,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
