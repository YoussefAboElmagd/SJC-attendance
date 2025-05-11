import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';

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
            onPressed: onSubmit,
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
  final TextEditingController? textEditingController;
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
            widget.cubit.changeDragDownHint(
              widget.textEditingController,
              value,
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

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
// import 'package:madarj/generated/l10n.dart';

// import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/widgets/app_button.dart';

// class CustomBottomSheet extends StatefulWidget {
//   const CustomBottomSheet({
//     super.key,
//     required this.label,
//     required this.hint,
//     required this.items,
//     required this.textEditingController,
//     this.onTap,
//     required this.cubit,
//   });

//   final SendLeaveCubit? cubit;
//   final String? label;
//   final String? hint;
//   final List<String> items;
//   final TextEditingController? textEditingController;
//   final void Function()? onTap;

//   @override
//   State<CustomBottomSheet> createState() => _CustomBottomSheetState();
// }

// class _CustomBottomSheetState extends State<CustomBottomSheet> {
//   String? selectedItem;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.label ?? 'Select Option',
//             style: TextStyles.font16BlackSemiBold.copyWith(
//               color: const Color(0xFF2A3183),
//             ),
//           ),
//           Text(
//             widget.hint ?? S.of(context).Select_Expense_Category,
//             style: TextStyles.font14GreyRegular,
//           ),
//           SizedBox(height: 16.h),
//           SizedBox(
//             height: 285.h,
//             child: Scrollbar(
//               thumbVisibility: true,
//               radius: Radius.circular(3.r),
//               child: ListView.separated(
//                 itemCount: widget.items.length,
//                 separatorBuilder: (_, __) => SizedBox(height: 10.h),
//                 itemBuilder: (_, index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1.w, color: Colors.grey),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                       child: Row(
//                         children: [
//                           Text(
//                             widget.items[index],
//                             style: TextStyles.font16BlackSemiBold,
//                           ),
//                           const Spacer(),
//                           Radio<String>(
//                             value: widget.items[index],
//                             groupValue: selectedItem,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedItem = value;
//                               });
//                               if (widget.cubit != null) {
//                                 widget.cubit!.changeDragDownHint(
//                                   widget.textEditingController,
//                                   selectedItem,
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: AppTextButton(
//                   hintText: S.of(context).Close_Message,
//                   buttonText: S.of(context).Close_Message,
//                   textStyle: TextStyles.font16GreyNormal,
//                   borderRadius: 30.r,
//                   onPressed: () => context.pop(),
//                   backgroundColor: ColorsManager.white,
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               Expanded(
//                 child: AppTextButton(
//                   hintText: S.of(context).Submit_Date,
//                   buttonText: S.of(context).Submit_Date,
//                   textStyle: selectedItem == null || selectedItem == ""
//                       ? TextStyles.font16WhiteNormal
//                       : TextStyles.font16WhiteSemiBold,
//                   onPressed: () => context.pop(),
//                   backgroundColor: selectedItem == null || selectedItem == ""
//                       ? ColorsManager.grey
//                       : ColorsManager.mainColor1,
//                   borderRadius: 30.r,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



// class _BottomSheetListItem extends StatelessWidget {
//   final String item;
//   final bool isSelected;
//   final ValueChanged<String?> onSelected;

//   const _BottomSheetListItem({
//     required this.item,
//     required this.isSelected,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onSelected(item), // This makes the whole row clickable

//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(width: 1.w, color: Colors.grey),
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//           child: Row(
//             children: [
//               Text(
//                 item,
//                 style: TextStyles.font16BlackSemiBold,
//               ),
//               const Spacer(),
//               Radio<String>(
//                 value: item,
//                 groupValue: isSelected ? item : null,
//                 onChanged: onSelected,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
// import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';
// import 'package:madarj/generated/l10n.dart';

// import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/widgets/app_button.dart';

// class CustomBottomSheet extends StatefulWidget {
//   const CustomBottomSheet({
//     super.key,
//     required this.label,
//     required this.hint,
//     required this.items,
//     required this.textEditingController,
//     this.onTap,
//     required this.cubit,
//   });

//   final SendLeaveCubit? cubit;
//   final String? label;
//   final String? hint;
//   final List<String> items;
//   final TextEditingController? textEditingController;
//   final void Function()? onTap;

//   @override
//   State<CustomBottomSheet> createState() => _CustomBottomSheetState();
// }

// class _CustomBottomSheetState extends State<CustomBottomSheet> {
//   String? selectedItem;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SendLeaveCubit, SendLeaveState>(
//       builder: (context, state) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.label ?? 'Select Option',
//                 style: TextStyles.font16BlackSemiBold.copyWith(
//                   color: const Color(0xFF2A3183),
//                 ),
//               ),
//               Text(
//                 widget.hint ?? S.of(context).Select_Expense_Category,
//                 style: TextStyles.font14GreyRegular,
//               ),
//               SizedBox(height: 16.h),
//               BottomSheetList(
//                 cubit: widget.cubit,
//                 label: widget.label,
//                 // hint: widget.hint,
//                 items: widget.items,
//                 textEditingController: widget.textEditingController,
//               ),
//               SizedBox(height: 16.h),
//               BottomSheetButtons(selectedItem: selectedItem),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class BottomSheetList extends StatefulWidget {
//   BottomSheetList({
//     super.key,
//     required this.label,
//     required this.items,
//     required this.textEditingController,
//     this.onTap,
//     required this.cubit,
//     this.selectedItem,
//   });

//   final SendLeaveCubit? cubit;
//   final String? label;
//   final List<String> items;
//   final TextEditingController? textEditingController;
//   final void Function()? onTap;
//   String? selectedItem;

//   @override
//   State<BottomSheetList> createState() => _BottomSheetListState();
// }

// class _BottomSheetListState extends State<BottomSheetList> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 285.h,
//       child: Scrollbar(
//         thumbVisibility: true,
//         radius: Radius.circular(3.r),
//         child: ListView.separated(
//           itemCount: widget.items.length,
//           separatorBuilder: (_, __) => SizedBox(height: 10.h),
//           itemBuilder: (_, index) {
//             return Container(
//               decoration: BoxDecoration(
//                 border: Border.all(width: 1.w, color: Colors.grey),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                 child: Row(
//                   children: [
//                     Text(
//                       widget.items[index],
//                       style: TextStyles.font16BlackSemiBold,
//                     ),
//                     const Spacer(),
//                     Radio<String>(
//                       activeColor: ColorsManager.mainColor1,
//                       value: widget.items[index],
//                       groupValue: widget.selectedItem,
//                       // groupValue: context.read<SendLeaveCubit>().selectedItem,
//                       onChanged: (value) {
//                         setState(() {
//                           widget.selectedItem = value;
//                         });
//                         print("widget.selectedItem ${widget.selectedItem}");
//                         print("widget.cubit ${widget.cubit}");
//                         if (widget.cubit != null) {
//                           widget.cubit!.changeDragDownHint(
//                             widget.textEditingController,
//                             widget.selectedItem,
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class BottomSheetButtons extends StatelessWidget {
//   const BottomSheetButtons({
//     super.key,
//     required this.selectedItem,
//   });

//   final String? selectedItem;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SendLeaveCubit, SendLeaveState>(
//       builder: (context, state) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: AppTextButton(
//                 hintText: S.of(context).Close_Message,
//                 buttonText: S.of(context).Close_Message,
//                 textStyle: TextStyles.font16GreyNormal,
//                 borderRadius: 30.r,
//                 onPressed: () => context.pop(),
//                 backgroundColor: ColorsManager.white,
//               ),
//             ),
//             SizedBox(width: 10.w),
//             Expanded(
//               child: AppTextButton(
//                 hintText: S.of(context).Submit_Date,
//                 buttonText: S.of(context).Submit_Date,
//                 textStyle:
//                     context.read<SendLeaveCubit>().selectedItem == null ||
//                             context.read<SendLeaveCubit>().selectedItem == ""
//                         ? TextStyles.font16WhiteNormal
//                         : TextStyles.font16WhiteSemiBold,
//                 onPressed: () => context.pop(),
//                 backgroundColor:
//                     context.read<SendLeaveCubit>().selectedItem == null ||
//                             context.read<SendLeaveCubit>().selectedItem == ""
//                         ? ColorsManager.grey
//                         : ColorsManager.mainColor1,
//                 borderRadius: 30.r,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
