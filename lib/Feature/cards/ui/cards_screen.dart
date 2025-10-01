import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madarj/Feature/cards/ui/widgets/cards_body.dart';


class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child:  const Scaffold(
        body: CardsBody(),
      ),
    );
  }
}
