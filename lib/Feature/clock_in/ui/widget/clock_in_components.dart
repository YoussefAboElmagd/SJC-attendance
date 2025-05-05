import 'package:flutter/material.dart';
import 'package:madarj/Core/themes/styles.dart';

class ClockInActionButton extends StatelessWidget {
  const ClockInActionButton({super.key, required this.lat, required this.long});
  final double? lat;
  final double? long;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buttonContainerDecoration,
      child: Padding(
        padding: _buttonPadding,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: _buttonDecoration,
          child: TextButton(
            onPressed: () => _handleClockIn(context),
            child: Text('Selfie To Clock In',
                style: TextStyles.font16WhiteSemiBold),
          ),
        ),
      ),
    );
  }

  void _handleClockIn(BuildContext context) {}

  BoxDecoration get _buttonContainerDecoration => BoxDecoration(
        boxShadow: [_buttonShadow],
        color: Colors.white,
      );

  BoxShadow get _buttonShadow => BoxShadow(
        color: const Color(0xFF2A3183).withOpacity(.2),
        blurRadius: 10.0,
        spreadRadius: 2.0,
        offset: const Offset(0, -4),
      );

  EdgeInsets get _buttonPadding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      );

  BoxDecoration get _buttonDecoration => BoxDecoration(
        gradient: _buttonGradient,
        borderRadius: BorderRadius.circular(30),
      );

  LinearGradient get _buttonGradient => const LinearGradient(
        colors: [
          Color(0xFF2A3183),
          Color(0xFF2A3183),
          Color(0xFF5B2ED4),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}





