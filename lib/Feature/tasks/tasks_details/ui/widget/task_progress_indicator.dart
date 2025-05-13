import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskProgressIndicator extends StatelessWidget {
  const TaskProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        4.r,
      ),
      child: LinearProgressIndicator(
        value: 0.25,
        backgroundColor: Colors.grey.shade300,
        valueColor: const AlwaysStoppedAnimation<Color>(
          Colors.indigo,
        ),
        minHeight: 4.h,
      ),
    );
  }
}