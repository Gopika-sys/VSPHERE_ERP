import 'package:flutter/material.dart';

class QuickActionsSection
    extends StatelessWidget {
  const QuickActionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person_add),
          label: const Text("Student"),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.book),
          label: const Text("Course"),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.campaign),
          label: const Text("Announcement"),
        ),
      ],
    );
  }
}