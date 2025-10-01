

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';

class BottomSheetListItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final ValueChanged<String?> onSelected;

  const BottomSheetListItem({super.key, 
    required this.item,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => onSelected(item),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Row(
            children: [
              Text(
                item,
                style: TextStyles.font16BlackSemiBold,
              ),
              const Spacer(),
              Radio<String>(
                value: item,
                groupValue: isSelected ? item : null,
                onChanged: (value) {
                  onSelected(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
