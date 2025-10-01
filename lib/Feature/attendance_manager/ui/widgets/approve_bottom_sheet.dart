import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Core/widgets/app_text_form_field.dart';

import 'package:madarj/generated/l10n.dart';

class ApproveRequestResult {
  final String? checkInNew;
  final String? checkOutNew;

  ApproveRequestResult({required this.checkInNew, required this.checkOutNew});
}

class ApproveRequestBottomSheet extends StatefulWidget {
  final String? initialCheckIn;
  final String? initialCheckOut;
  final String? employeeName;

  const ApproveRequestBottomSheet({
    super.key,
    this.initialCheckIn,
    this.initialCheckOut,
    this.employeeName,
  });

  @override
  State<ApproveRequestBottomSheet> createState() =>
      _ApproveRequestBottomSheetState();
}

class _ApproveRequestBottomSheetState extends State<ApproveRequestBottomSheet> {
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  DateTime? selectedCheckInDate;
  TimeOfDay? selectedCheckInTime;
  DateTime? selectedCheckOutDate;
  TimeOfDay? selectedCheckOutTime;

  @override
  void initState() {
    super.initState();
    checkInController = TextEditingController(
      text: widget.initialCheckIn ?? '',
    );
    checkOutController = TextEditingController(
      text: widget.initialCheckOut ?? '',
    );
  }

  @override
  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(bool isCheckIn) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.mainColor1,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorsManager.mainColor1,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final formattedDate = DateFormat(
          'yyyy-MM-dd',
          'en',
        ).format(fullDateTime);

        final formattedTime = DateFormat('HH:mm:ss', 'en').format(fullDateTime);

        final displayText = '$formattedDate => $formattedTime';

        setState(() {
          if (isCheckIn) {
            checkInController.text = displayText;
            selectedCheckInDate = pickedDate;
            selectedCheckInTime = pickedTime;
          } else {
            checkOutController.text = displayText;
            selectedCheckOutDate = pickedDate;
            selectedCheckOutTime = pickedTime;
          }
        });
      }
    }
  }

  void _handleApprove() {
    if (checkInController.text.isEmpty || checkOutController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_select_both_times),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final checkInParts = checkInController.text.split(' => ');
      final checkOutParts = checkOutController.text.split(' => ');

      if (checkInParts.length != 2 || checkOutParts.length != 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).invalid_date_format),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final checkInDateTimeStr = '${checkInParts[0]} ${checkInParts[1]}';
      final checkOutDateTimeStr = '${checkOutParts[0]} ${checkOutParts[1]}';

      final checkIn = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
        'en',
      ).parse(checkInDateTimeStr);
      final checkOut = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
        'en',
      ).parse(checkOutDateTimeStr);

      if (checkOut.isBefore(checkIn)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).checkout_must_be_after_checkin),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).invalid_date_format),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // إرجاع النتيجة
    final result = ApproveRequestResult(
      checkInNew: checkInController.text,
      checkOutNew: checkOutController.text,
    );
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Title
              Text(
                S.of(context).approve_request,
                style: TextStyles.font18BlackBold,
              ),
              SizedBox(height: 8.h),

              // Employee Name
              if (widget.employeeName != null) ...[
                Text(
                  '${S.of(context).employee}: ${widget.employeeName}',
                  style: TextStyles.font14GreyRegular,
                ),
                SizedBox(height: 20.h),
              ],

              // Check In Field
              Text(
                S.of(context).check_in_time,
                style: TextStyles.font14BlackSemiBold,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _selectDateTime(true),
                child: AbsorbPointer(
                  child: AppTextFormField(
                    controller: checkInController,
                    readOnly: true,
                    hintText: S.of(context).select_check_in_time,
                    inputTextStyle: TextStyles.font14BlackRegular,
                    hintStyle: TextStyles.font14GreyRegular,
                    backgroundColor: Colors.white,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: ColorsManager.mainColor1,
                      size: 20.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: ColorsManager.mainColor1,
                      ),
                    ),
                    validator: (value) => null,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Check Out Field
              Text(
                S.of(context).check_out_time,
                style: TextStyles.font14BlackSemiBold,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _selectDateTime(false),
                child: AbsorbPointer(
                  child: AppTextFormField(
                    controller: checkOutController,
                    readOnly: true,
                    hintText: S.of(context).select_check_out_time,
                    inputTextStyle: TextStyles.font14BlackRegular,
                    hintStyle: TextStyles.font14GreyRegular,
                    backgroundColor: Colors.white,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: ColorsManager.mainColor1,
                      size: 20.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: ColorsManager.mainColor1,
                      ),
                    ),
                    validator: (value) => null,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      buttonText: S.of(context).cancel,
                      textStyle: TextStyles.font14BlackSemiBold,
                      backgroundColor: Colors.grey[200]!,
                      onPressed: () => Navigator.pop(context),
                      hintText: '',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppTextButton(
                      buttonText: S.of(context).approve,
                      textStyle: TextStyles.font14WhiteSemiBold,
                      backgroundColor: ColorsManager.mainColor1,
                      onPressed: _handleApprove,
                      hintText: '',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. Helper Function لفتح الـ Bottom Sheet
Future<ApproveRequestResult?> showApproveRequestBottomSheet(
  BuildContext context, {
  String? initialCheckIn,
  String? initialCheckOut,
  String? employeeName,
}) {
  return showModalBottomSheet<ApproveRequestResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => ApproveRequestBottomSheet(
          initialCheckIn: initialCheckIn,
          initialCheckOut: initialCheckOut,
          employeeName: employeeName,
        ),
  );
}
