import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UserNameRow(),
        SizedBox(height: 4),
        _DateText(),
        SizedBox(height: 4),
        _LocationRow(),
      ],
    );
  }
}

class _UserNameRow extends StatelessWidget {
  const _UserNameRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Tonald Drump",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 4),
        Icon(Icons.verified, color: Colors.blue, size: 16),
      ],
    );
  }
}

class _DateText extends StatelessWidget {
  const _DateText();

  @override
  Widget build(BuildContext context) {
    return Text(
        "${DateTime.now().day} ${DateFormat('MMM').format(DateTime.now())}  ${DateTime.now().year} ");
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey),
        SizedBox(width: 4),
        Text("Lat 45.43534 Long 97897.576"),
      ],
    );
  }
}
