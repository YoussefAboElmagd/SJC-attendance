import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/bottom_sheet_list_item.dart';

class BottomSheetList extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onItemSelected;

  const BottomSheetList({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285.h,
      child: Scrollbar(
        thumbVisibility: true,
        radius: Radius.circular(3.r),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (_, index) {
            return BottomSheetListItem(
              item: items[index],
              isSelected: selectedItem == items[index],
              onSelected: onItemSelected,
            );
          },
        ),
      ),
    );
  }
}
