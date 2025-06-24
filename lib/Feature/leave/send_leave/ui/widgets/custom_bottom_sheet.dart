import 'package:flutter/material.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/bottom_sheet_buttons.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/bottom_sheet_list.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/custom_bottom_sheet_content.dart';

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
  final String? buttonText;
  final String? buttonText2;

  CustomBottomSheet({
    super.key,
    this.label,
    this.hint,
    this.buttonText,
    required this.items,
    this.textEditingController,
    required this.cubit,
    this.onTap,
    this.itemsId,
    this.itemsMap,
    this.id,
    this.buttonText2,
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
          setState(() => selectedItem = value);
          if (value != null) {
            widget.itemsMap == null || widget.itemsMap!.isEmpty
                ? widget.cubit.changeDragDownHint(
                    widget.textEditingController,
                    value,
                  )
                : widget.cubit.changeDragDownHint(
                    widget.textEditingController,
                    widget.id,
                    value,
                    findKeyForValue(widget.itemsMap!, value),
                  );
          }
        },
      ),
      buttonsRow: BottomSheetButtons(
        buttonText: widget.buttonText,
        buttonText2: widget.buttonText2,
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
