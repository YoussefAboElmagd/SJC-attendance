// // ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/assets.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';

class DropDownListById extends FormField<String> {
  DropDownListById({
    super.key,
    required String text,
    required String selectedValue,
    required List<dynamic> list,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
    IconStyleData? customIconStyleData,
  }) : super(
         initialValue: selectedValue.isNotEmpty ? selectedValue : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: EdgeInsets.symmetric(horizontal: 15.w),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color: state.hasError ? ColorsManager.red : ColorsManager.grey,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 10),
                 bottomRight: Radius.circular(radiusBottomRight ?? 10),
                 topLeft: Radius.circular(radiusTopLeft ?? 10),
                 topRight: Radius.circular(radiusTopRight ?? 10),
               ),
             ),
             height: 45.h,
             width: double.infinity,
           );
           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.mainColor,
             ),
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items: list.map((itemData) {
                     return DropdownMenuItem<String>(
                       value: itemData.id.toString(),
                       child: Text(
                         itemData.name,
                         style: TextStyles.font14MainColorBold,
                       ),
                     );
                   }).toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: customIconStyleData ?? iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(left: 18.w, top: 8),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12RedBold,
                   ),
                 ),
             ],
           );
         },
       );
}

class DropDownListByIdAR extends FormField<String> {
  DropDownListByIdAR({
    super.key,
    required String text,
    required String selectedValue,
    required List<dynamic> list,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
    IconStyleData? customIconStyleData,
  }) : super(
         initialValue: selectedValue.isNotEmpty ? selectedValue : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: EdgeInsets.symmetric(horizontal: 15.w),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color: state.hasError ? ColorsManager.red : ColorsManager.grey,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 10),
                 bottomRight: Radius.circular(radiusBottomRight ?? 10),
                 topLeft: Radius.circular(radiusTopLeft ?? 10),
                 topRight: Radius.circular(radiusTopRight ?? 10),
               ),
             ),
             height: 45.h,
             width: double.infinity,
           );
           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.mainColor,
             ),
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items: list.map((itemData) {
                     return DropdownMenuItem<String>(
                       value: itemData.id.toString(),
                       child: Text(
                         itemData.nameAR,
                         style: TextStyles.font14MainColorBold,
                       ),
                     );
                   }).toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: customIconStyleData ?? iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(left: 18.w, top: 8),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12RedBold,
                   ),
                 ),
             ],
           );
         },
       );
}

class DropDownList extends FormField<String> {
  DropDownList({
    super.key,
    required String text,
    required List<String> list,
    required String selectedValue,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    double? fontSize,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
  }) : super(
         initialValue: selectedValue.isNotEmpty ? selectedValue : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: EdgeInsets.symmetric(horizontal: 15.w),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color: state.hasError ? ColorsManager.red : ColorsManager.grey,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 10),
                 bottomRight: Radius.circular(radiusBottomRight ?? 10),
                 topLeft: Radius.circular(radiusTopLeft ?? 10),
                 topRight: Radius.circular(radiusTopRight ?? 10),
               ),
             ),
             height: 45.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.mainColor,
             ),
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items: list
                       .map(
                         (item) => DropdownMenuItem(
                           value: item,
                           child: Text(
                             item,
                             style:
                                 textStyle ??
                                 TextStyle(fontSize: fontSize ?? 20),
                           ),
                         ),
                       )
                       .toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(left: 15.w),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12RedBold,
                   ),
                 ),
             ],
           );
         },
       );
}
