import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
// import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/routing/routes.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/cards/ui/widgets/cards_body.dart';
// import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
// import 'package:madarj/generated/l10n.dart';
// import 'dart:math' as math;

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child:  Scaffold(
        body: CardsBody(),
      ),
    );
  }
}
