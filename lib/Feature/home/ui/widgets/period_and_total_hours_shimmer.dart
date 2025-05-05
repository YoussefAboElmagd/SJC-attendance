import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PeriodAndTotalHoursShimmer extends StatelessWidget {
  const PeriodAndTotalHoursShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: _buildShimmerBox(),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: _buildShimmerBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerBox() {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
  }
}
