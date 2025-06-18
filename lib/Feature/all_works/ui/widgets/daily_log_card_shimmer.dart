import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/all_works/ui/widgets/shimmer_box_container.dart';
import 'package:madarj/Feature/all_works/ui/widgets/shimmer_container.dart';

class DailyLogCardShimmer extends StatelessWidget {
  const DailyLogCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(width: 120.w, height: 16.h),
          SizedBox(height: 8.h),
          ShimmerBoxContainer(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(width: 80.w, height: 12.h),
                  SizedBox(height: 8.h),
                  _shimmerBox(width: 60.w, height: 16.h),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(width: 100.w, height: 12.h),
                  SizedBox(height: 8.h),
                  _shimmerBox(width: 120.w, height: 16.h),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.r)),
    );
  }
}

