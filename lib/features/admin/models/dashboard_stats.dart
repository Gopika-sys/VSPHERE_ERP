import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardStats {
  final int totalStudents;
  final int activeCourses;
  final double averageAttendance;
  final double totalRevenue;
  final double pendingDues;

  DashboardStats({
    required this.totalStudents,
    required this.activeCourses,
    required this.averageAttendance,
    required this.totalRevenue,
    required this.pendingDues,
  });

  factory DashboardStats.fromMap(Map<String, dynamic> map) {
    return DashboardStats(
      totalStudents: map['total_students'] ?? 0,
      activeCourses: map['active_courses'] ?? 0,
      averageAttendance: (map['average_attendance'] ?? 0.0).toDouble(),
      totalRevenue: (map['total_revenue'] ?? 0.0).toDouble(),
      pendingDues: (map['pending_dues'] ?? 0.0).toDouble(),
    );
  }

  factory DashboardStats.empty() {
    return DashboardStats(
      totalStudents: 0,
      activeCourses: 0,
      averageAttendance: 0.0,
      totalRevenue: 0.0,
      pendingDues: 0.0,
    );
  }
}

class DashboardData {
  final DashboardStats stats;
  final List<BarChartGroupData> revenueData;
  final List<PieChartSectionData> departmentData;
  final List<FlSpot> attendanceData;

  DashboardData({
    required this.stats,
    required this.revenueData,
    required this.departmentData,
    required this.attendanceData,
  });
}
