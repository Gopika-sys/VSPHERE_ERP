import 'package:flutter/material.dart';

class EmptyStateCard extends StatelessWidget {
  final String title;

  const EmptyStateCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Center(
          child: Text(
            "$title\n\nNo data available",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}