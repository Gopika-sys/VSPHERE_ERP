import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FeeInvoicesRevenueChart extends StatelessWidget {
  final List<BarChartGroupData> data;

  const FeeInvoicesRevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No revenue data available", style: TextStyle(color: Colors.grey, fontSize: 12)));
    }
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 40000,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                if (value.toInt() < titles.length) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(titles[value.toInt()], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 8000 == 0) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text('${(value/1000).toInt()}k', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.shade100,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: data,
      ),
    );
  }
}

class DepartmentSharesChart extends StatelessWidget {
  final List<PieChartSectionData> data;

  const DepartmentSharesChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade100, width: 20),
          ),
          child: const Center(child: Text("No Data", style: TextStyle(color: Colors.grey, fontSize: 10))),
        ),
      );
    }
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 50,
        sections: data,
      ),
    );
  }
}

class WeeklyAttendanceChart extends StatelessWidget {
  final List<FlSpot> spots;

  const WeeklyAttendanceChart({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) {
      return const Center(child: Text("No attendance data available", style: TextStyle(color: Colors.grey, fontSize: 12)));
    }
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: const Color(0xFF0061FF),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF0061FF).withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
