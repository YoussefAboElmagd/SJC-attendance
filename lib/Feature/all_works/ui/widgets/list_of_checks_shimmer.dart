import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks_shimmer.dart';

class ListOfChecksShimmer extends StatelessWidget {
  const ListOfChecksShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (_, __) => SizedBox(height: 15.h),
      itemBuilder: (_, __) => const DailyLogCardShimmer(),
    );
  }
}