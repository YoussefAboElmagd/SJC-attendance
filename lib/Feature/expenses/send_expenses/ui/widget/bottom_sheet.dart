import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/generated/l10n.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.textEditingController,
    this.onTap,
  });

  final String? label;
  final String? hint;
  final List<String> items;
  TextEditingController? textEditingController;
  final void Function()? onTap;
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    // return StatefulBuilder(
    // builder: (BuildContext context, StateSetter setState) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ?? 'Select Option',
            style: TextStyles.font16BlackSemiBold.copyWith(
              color: const Color(0xFF2A3183),
            ),
          ),
          Text(
            widget.hint ?? S.of(context).Select_Expense_Category,
            style: TextStyles.font14GreyRegular,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 285.h,
            child: Scrollbar(
              thumbVisibility: true,
              radius: Radius.circular(
                3.r,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.w,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      child: InkWell(
                        onTap: widget.onTap ??
                            () {
                              setState(() {
                                selectedItem = widget.items[index];
                                if (widget.textEditingController != null) {
                                  widget.textEditingController!.text =
                                      selectedItem!;
                                  print(widget.textEditingController!.text);
                                }
                              });
                            },
                        child: Row(
                          children: [
                            Text(
                              widget.items[index],
                              style: TextStyles.font16BlackSemiBold,
                            ),
                            const Spacer(),
                            Radio<String>(
                              value: widget.items[index],
                              groupValue: selectedItem,
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppTextButton(
                  hintText: S.of(context).Close_Message,
                  buttonText: S.of(context).Close_Message,
                  textStyle: TextStyles.font16GreyNormal,
                  borderRadius: 30.r,
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: ColorsManager.white,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: AppTextButton(
                  hintText: S.of(context).Submit_Date,
                  buttonText: S.of(context).Submit_Date,
                  textStyle: selectedItem == null || selectedItem == ""
                      ? TextStyles.font16WhiteNormal
                      : TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: selectedItem == null || selectedItem == ""
                      ? ColorsManager.grey
                      : ColorsManager.mainColor1,
                  borderRadius: 30.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
