import 'package:flutter/material.dart';
Widget SkillCard(BuildContext context, double screenWidth, String text) {
  double cardWidth = screenWidth <= 420 ? (screenWidth * 0.8) /3 : 120;

  return Card(
    child: SizedBox(
      width: cardWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black87),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
