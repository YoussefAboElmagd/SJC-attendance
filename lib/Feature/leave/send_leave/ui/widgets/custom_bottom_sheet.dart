import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/widgets/app_button.dart';
// import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';

class CustomBottomSheetContent extends StatelessWidget {
  final String? label;
  final String? hint;
  final Widget listContent;
  final Widget buttonsRow;

  const CustomBottomSheetContent({
    super.key,
    this.label,
    this.hint,
    required this.listContent,
    required this.buttonsRow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? 'Select Option',
            style: TextStyles.font16BlackSemiBold.copyWith(
              color: const Color(0xFF2A3183),
            ),
          ),
          Text(
            hint ?? S.of(context).Select_Expense_Category,
            style: TextStyles.font14GreyRegular,
          ),
          SizedBox(height: 16.h),
          listContent,
          SizedBox(height: 16.h),
          buttonsRow,
        ],
      ),
    );
  }
}

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
            return _BottomSheetListItem(
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

class _BottomSheetListItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final ValueChanged<String?> onSelected;

  const _BottomSheetListItem({
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
                  // Explicitly handle radio button change
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

class BottomSheetButtons extends StatelessWidget {
  final bool hasSelection;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  const BottomSheetButtons({
    super.key,
    required this.hasSelection,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppTextButton(
            hintText: S.of(context).Close_Message,
            buttonText: S.of(context).Close_Message,
            textStyle: TextStyles.font16GreyNormal,
            borderRadius: 30.r,
            onPressed: onClose,
            backgroundColor: ColorsManager.white,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: AppTextButton(
            hintText: S.of(context).Submit_Date,
            buttonText: S.of(context).Submit_Date,
            textStyle: hasSelection
                ? TextStyles.font16WhiteSemiBold
                : TextStyles.font16WhiteNormal,
            onPressed: () {
              if (hasSelection) {
                context.pop();
              }
            },
            backgroundColor:
                hasSelection ? ColorsManager.mainColor1 : ColorsManager.grey,
            borderRadius: 30.r,
          ),
        ),
      ],
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  final String? label;
  final String? hint;
  final List<String> items;
  final List<String>? itemsId;
  final Map<String, String>? itemsMap;
  final TextEditingController? textEditingController;
  final TextEditingController? id;
  var cubit;
  final void Function()? onTap;

  CustomBottomSheet({
    super.key,
    this.label,
    this.hint,
    required this.items,
    this.textEditingController,
    required this.cubit,
    this.onTap,
    this.itemsId,
    this.itemsMap,
    this.id,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContent(
      label: widget.label,
      hint: widget.hint,
      listContent: BottomSheetList(
        items: widget.items,
        selectedItem: selectedItem,
        onItemSelected: (value) {
          setState(
            () => selectedItem = value,
          );
          if (value != null) {
            widget.itemsMap == null || widget.itemsMap!.isEmpty
                ? widget.cubit
                    .changeDragDownHint(widget.textEditingController, value)
                : widget.cubit.changeDragDownHint(
                    widget.textEditingController,
                    widget.id,
                    value,
                    findKeyForValue(
                      widget.itemsMap!,
                      value,
                    ),
                  );
          }
        },
      ),
      buttonsRow: BottomSheetButtons(
        hasSelection: selectedItem != null && selectedItem!.isNotEmpty,
        onClose: () => Navigator.pop(context),
        onSubmit: () => Navigator.pop(context),
      ),
    );
  }
}

String? findKeyForValue(Map<String, dynamic>? itemsMap, dynamic value) {
  if (itemsMap == null || itemsMap.isEmpty) return null;

  try {
    return itemsMap.keys.firstWhere(
      (key) => itemsMap[key] == value,
      orElse: () => "",
    );
  } catch (e) {
    return null;
  }
}
