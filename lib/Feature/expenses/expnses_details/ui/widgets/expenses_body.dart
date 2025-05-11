import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_state.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/expenses.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesBody extends StatelessWidget {
  const ExpensesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const ExpensesTopHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SizedBox(
                    height: (MediaQuery.sizeOf(context).height - 250.h),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpensesBodyWidgets(),
                        // Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const BottomExpensesButton(),
          ],
        );
      },
    );
  }
}

class ExpensesBodyWidgets extends StatelessWidget {
  const ExpensesBodyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TotalExpenses(),
        SizedBox(height: 15.h),
        const TabsScreen(),
      ],
    );
  }
}

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;

  List<Widget> screens = const [
    ListOfExpenses(),
    ListOfExpenses(),
    ListOfExpenses(),
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
                title: 'Review',
                isSelected: selectedIndex == 0,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              BuildTap(
                title: 'Approved',
                isSelected: selectedIndex == 1,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              BuildTap(
                title: 'Rejected',
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

class BuildReviewScreen extends StatelessWidget {
  const BuildReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}

class TotalExpenses extends StatelessWidget {
  const TotalExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15.r,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Total_Expense_Text,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${S.of(context).Period_text} 1 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year} - 30 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}',
                    style: TextStyles.font14BlackSemiBold.copyWith(
                      color: const Color.fromRGBO(
                        71,
                        84,
                        103,
                        1,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const ListOfTotalExpenses(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListOfExpenses extends StatelessWidget {
  const ListOfExpenses({
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
                        child: const ExpensesLogCard(),
                      )
                    : const ExpensesLogCard();
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemCount: 10,
            ),
    );
  }
}

class ExpensesLogCard extends StatelessWidget {
  // final TodayWorkDayEntry workDayEntry;

  const ExpensesLogCard({
    super.key,
    // required this.workDayEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/expenses.svg"),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "${DateTime.now().day} ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}",
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Hours,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                            71,
                            84,
                            103,
                            1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        // workDayEntry.workedHours!.replaceAll("and", "&"),
                        "E-Learning",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Expense_Text,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                            71,
                            84,
                            103,
                            1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "\$55",
                        // "${workDayEntry.checkIn ?? S.of(context).No_checkIn} - ${workDayEntry.checkOut ?? S.of(context).No_checkout}", // .replaceFirst("and", "\\"),
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseItem {
  final String imagePath;
  final String title;
  final String amount;

  ExpenseItem({
    required this.imagePath,
    required this.title,
    required this.amount,
  });
}

class ListOfTotalExpenses extends StatelessWidget {
  const ListOfTotalExpenses({super.key});
  @override
  Widget build(BuildContext context) {
    final List<ExpenseItem> expenseItems = [
      ExpenseItem(
        imagePath: 'assets/images/card-pos.png',
        title: S.of(context).Total_text,
        amount: '200',
      ),
      ExpenseItem(
        imagePath: 'assets/images/orange_circle.png',
        title: S.of(context).Review_text,
        amount: '500',
      ),
      ExpenseItem(
        imagePath: 'assets/images/green_circle.png',
        title: S.of(context).Approved_Text,
        amount: '300',
      ),
    ];

    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                  child: ExpensesDetails(
                    image: expenseItems[index].imagePath,
                    title: expenseItems[index].title,
                    price: expenseItems[index].amount,
                    imageWidth: index == 0 ? 25.w : 10.w,
                    imageheight: index == 0 ? 25.w : 10.w,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 15.w,
                );
              },
              itemCount: 3,
            ),
          )
          // ExpensesDetails(),
        ],
      ),
    );
  }
}

class ExpensesDetails extends StatelessWidget {
  const ExpensesDetails({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.imageheight,
    this.imageWidth,
  });
  final String? image;
  final double? imageheight;
  final double? imageWidth;
  final String? title;
  final String? price;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
        border: Border.all(
          color: ColorsManager.lighterGray,
          width: 1.w,
        ),
        color: ColorsManager.grey2,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 22.w,
          left: 12.h,
          top: 15.h,
          bottom: 13.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  image ?? "assets/images/card-pos.png",
                  width: imageWidth ?? 25.w,
                  height: imageheight ?? 25.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  title ?? S.of(context).Total_text,
                  style: TextStyles.font16lightBlackSemiBold,
                ),
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              "\$ ${price ?? "200"}",
              style: TextStyles.font18BlackSemiBold,
            ),
          ],
        ),
      ),
    );
  }
}

class ExpensesTopHeader extends StatelessWidget {
  const ExpensesTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 235.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(42, 49, 131, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    S.of(context).Expense_Summary,
                    style: TextStyles.font26WhiteBold,
                  ),
                  Text(
                    S.of(context).Claim_expenses,
                    // "Don’t miss your clock in schedule",
                    style: TextStyles.font14GreyRegular.copyWith(
                      color: const Color.fromRGBO(217, 214, 254, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15.w),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/visa.png",
                  height: 100.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildTap extends StatelessWidget {
  const BuildTap({
    super.key,
    required this.title,
    required this.isSelected,
    required this.badgeCount,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.mainColor1 : Colors.white,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20.r),
              left: Radius.circular(20.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyles.font16BlackNormal.copyWith(
                  color: isSelected
                      ? ColorsManager.white
                      : ColorsManager.lightblack,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              SizedBox(width: 5.w),
              if (badgeCount > 0)
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : ColorsManager.grey3,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    badgeCount.toString(),
                    style: TextStyles.font16WhiteNormal,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class BuildTap extends StatelessWidget {
//   const BuildTap(
//       {super.key,
//       required this.title,
//       required this.isSelected,
//       required this.badgeCount});
//   final String title;
//   final bool isSelected;
//   final int badgeCount;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           // horizontal: 15.w,
//           vertical: 5.h,
//         ),
//         decoration: BoxDecoration(
//           color: isSelected ? ColorsManager.mainColor1 : Colors.white,
//           borderRadius: BorderRadius.horizontal(
//             right: Radius.circular(20.r),
//             left: Radius.circular(20.r),
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: TextStyles.font16BlackNormal.copyWith(
//                 color:
//                     isSelected ? ColorsManager.white : ColorsManager.lightblack,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             if (badgeCount > 0)
//               Container(
//                 margin: EdgeInsets.only(top: 4.h),
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.red : ColorsManager.grey3,
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   badgeCount.toString(),
//                   style: TextStyles.font16WhiteNormal,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
