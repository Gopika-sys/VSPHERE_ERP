import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/dashboard_stats.dart';
import 'kpi_card.dart';

class DashboardKpiSection extends StatelessWidget {
  final DashboardStats stats;

  const DashboardKpiSection({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KpiCard(
          title: "Total Students Enrolled",
          value: stats.totalStudents.toString(),
          subtitle: "Active student registrations",
          icon: Iconsax.user_tag,
          iconBgColor: const Color(0xFFE8F1FF),
          iconColor: const Color(0xFF0061FF),
        ),
        KpiCard(
          title: "Active Courses",
          value: stats.activeCourses.toString(),
          subtitle: "Across 5 departments",
          icon: Iconsax.book_1,
          iconBgColor: const Color(0xFFE8FFF3),
          iconColor: const Color(0xFF00C566),
        ),
        KpiCard(
          title: "Average Attendance",
          value: "${stats.averageAttendance}%",
          subtitle: "Current academic session",
          icon: Iconsax.task,
          iconBgColor: const Color(0xFFFFF7E8),
          iconColor: const Color(0xFFFFBB38),
        ),
        KpiCard(
          title: "Fee Collection Status",
          value: "₹${stats.totalRevenue > 1000 ? '${(stats.totalRevenue/1000).toStringAsFixed(1)}k' : stats.totalRevenue}",
          subtitle: "Pending dues: ₹${stats.pendingDues > 1000 ? '${(stats.pendingDues/1000).toStringAsFixed(1)}k' : stats.pendingDues}",
          icon: Iconsax.wallet_money,
          iconBgColor: const Color(0xFFF3E8FF),
          iconColor: const Color(0xFF9B51E0),
        ),
      ],
    );
  }
}
