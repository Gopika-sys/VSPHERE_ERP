import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/dashboard_stats.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_topbar.dart';
import '../widgets/analytics_section.dart';
import '../widgets/chart_legends.dart';
import '../widgets/dashboard_charts.dart';
import '../widgets/dashboard_kpi_section.dart';
import 'admin_panel_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int selectedIndex = 0;
  late Future<DashboardData> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = _fetchDashboardData();
  }

  // This will later be replaced with your MongoDB/Backend integration
  Future<DashboardData> _fetchDashboardData() async {
    // No mock data - initializing with empty/zeroed state
    // Data will be populated once MongoDB is connected
    
    final stats = DashboardStats.empty();

    final List<BarChartGroupData> revenueData = [];

    final List<PieChartSectionData> departmentData = [];

    final List<FlSpot> attendanceData = [];

    return DashboardData(
      stats: stats,
      revenueData: revenueData,
      departmentData: departmentData,
      attendanceData: attendanceData,
    );
  }

  BarChartGroupData _makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: const Color(0xFF0061FF), width: 8, borderRadius: BorderRadius.circular(2)),
        BarChartRodData(toY: y2, color: const Color(0xFFFFBB38), width: 8, borderRadius: BorderRadius.circular(2)),
      ],
    );
  }

  final List<String> pageTitles = [
    "Dashboard", "Students", "Academic", "LMS", "Attendance",
    "Exams", "Fees & Finance", "HR & Payroll", "Library",
    "Hostel", "Communication", "Reports", "Settings", "Admin Panel",
  ];

  Widget _buildDashboardContent() {
    return FutureBuilder<DashboardData>(
      future: _dashboardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error loading data: ${snapshot.error}"));
        }

        final data = snapshot.data!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Institutional Overview",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
              ),
              const SizedBox(height: 4),
              const Text(
                "Key performance indicators for V Sphere ERP",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              DashboardKpiSection(stats: data.stats),

              const SizedBox(height: 8),

              AnalyticsSection(
                title: "Fee Invoices & Revenue",
                subtitle: "Collected vs. outstanding pending payments",
                actionIcon: Iconsax.status_up,
                chart: FeeInvoicesRevenueChart(data: data.revenueData),
                legend: data.revenueData.isEmpty ? null : const WrapLegend(
                  items: [
                    LegendItem(color: Color(0xFF0061FF), label: "Collected"),
                    LegendItem(color: Color(0xFFFFBB38), label: "Pending"),
                  ],
                ),
              ),

              AnalyticsSection(
                title: "Department Shares",
                subtitle: "Student enrollment distribution",
                actionIcon: Iconsax.user_octagon,
                chart: DepartmentSharesChart(data: data.departmentData),
                legend: data.departmentData.isEmpty ? null : const WrapLegend(
                  items: [
                    LegendItem(color: Colors.purple, label: "Civil Engineering"),
                    LegendItem(color: Colors.green, label: "Computer Science"),
                    LegendItem(color: Colors.blue, label: "Electrical Engineering"),
                    LegendItem(color: Colors.pink, label: "Information Technology"),
                    LegendItem(color: Colors.orange, label: "Mechanical Engineering"),
                  ],
                ),
              ),

              AnalyticsSection(
                title: "Weekly Class Attendance",
                subtitle: "Average percentage rate tracker",
                actionIcon: Iconsax.calendar_1,
                chart: WeeklyAttendanceChart(spots: data.attendanceData),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModulePage(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Frontend UI under development", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (selectedIndex) {
      case 0: return _buildDashboardContent();
      case 13: return const AdminPanelScreen();
      default: return _buildModulePage(pageTitles[selectedIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      drawer: isMobile
          ? Drawer(
              child: AdminSidebar(
                selectedIndex: selectedIndex,
                onItemTap: (index) {
                  setState(() => selectedIndex = index);
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            AdminSidebar(
              selectedIndex: selectedIndex,
              onItemTap: (index) => setState(() => selectedIndex = index),
            ),
          Expanded(
            child: Column(
              children: [
                AdminTopBar(isMobile: isMobile, pageTitle: pageTitles[selectedIndex]),
                Expanded(child: _getSelectedPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
