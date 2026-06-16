import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style:
                    AppTextStyles.bodySmall,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                  iconColor.withValues(alpha: 0.15),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              value,
              style: AppTextStyles.cardValue,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style:
              AppTextStyles.bodySmall.copyWith(
                color:
                AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}