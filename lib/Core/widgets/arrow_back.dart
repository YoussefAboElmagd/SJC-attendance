import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/extensions.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        return Container(
          child: !ApplicationCubit.get(context).isArabic
              ? GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Image(
                    height: 30.h,
                    width: 30.w,
                    image: const AssetImage(
                      "assets/images/arrow_back-removebg-preview (1).png",
                    ),
                  ),
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(
                    math.pi,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Image(
                      height: 30.h,
                      width: 30.w,
                      image: const AssetImage(
                        "assets/images/arrow_back-removebg-preview (1).png",
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
