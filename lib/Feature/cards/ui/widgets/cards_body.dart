import 'package:flutter/material.dart';
import 'package:madarj/Feature/cards/ui/widgets/cards_grid.dart';
import 'package:madarj/Feature/cards/ui/widgets/home_header.dart';

class CardsBody extends StatelessWidget {
  const CardsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomeHeader(),
        CardsGrid(),
      ],
    );
  }
}

