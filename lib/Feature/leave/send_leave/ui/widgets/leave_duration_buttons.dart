import 'package:flutter/material.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveDurationButtons extends StatelessWidget {
  const LeaveDurationButtons({
    super.key,
    this.startDate,
    this.endDate,
  });

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // cubit.changeDragDownHint(
              //         controller,
              //         "$startDate:$endDate",
              //       );
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: startDate != null && endDate != null
                  ? ColorsManager.mainColor1
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              S.of(context).Submit_Date,
              style: startDate != null && endDate != null
                  ? TextStyles.font16WhiteSemiBold
                  : TextStyles.font16BlackSemiBold.copyWith(
                      color: ColorsManager.mainColor1,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 10),
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