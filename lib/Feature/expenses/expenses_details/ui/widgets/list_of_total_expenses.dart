import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/widgets/expenses_details.dart';
import 'package:madarj/generated/l10n.dart';

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
                return SizedBox(width: 15.w);
              },
              itemCount: 3,
            ),
          ),
          // ExpensesDetails(),
        ],
      ),
    );
  }
}
