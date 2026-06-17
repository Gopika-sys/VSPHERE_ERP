import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/iam_models.dart';

class IAMStatsCards extends StatelessWidget {
  final IAMStats stats;

  const IAMStatsCards({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              _buildStatCard(
                context,
                title: "TOTAL USERS",
                value: stats.totalUsers == 0 ? "--" : stats.totalUsers.toString(),
                icon: Iconsax.profile_2user,
                color: Colors.blue,
                isSelected: true,
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                context,
                title: "USER GROUPS",
                value: stats.userGroups == 0 ? "--" : stats.userGroups.toString(),
                icon: Iconsax.element_3,
                color: Colors.purple,
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                context,
                title: "POLICIES",
                value: stats.totalPolicies == 0 ? "--" : stats.totalPolicies.toString(),
                icon: Iconsax.shield_tick,
                color: Colors.green,
              ),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                title: "TOTAL USERS",
                value: stats.totalUsers == 0 ? "--" : stats.totalUsers.toString(),
                icon: Iconsax.profile_2user,
                color: Colors.blue,
                isSelected: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                title: "USER GROUPS",
                value: stats.userGroups == 0 ? "--" : stats.userGroups.toString(),
                icon: Iconsax.element_3,
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                title: "POLICIES",
                value: stats.totalPolicies == 0 ? "--" : stats.totalPolicies.toString(),
                icon: Iconsax.shield_tick,
                color: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    bool isSelected = false,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.blue : const Color(0xFFE2E8F0),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1C1E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
