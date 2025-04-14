import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/drawer/home_drawer.dart';
import '../controller/graph_controller.dart';


class GraphScreen extends GetView<GraphController> {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inject the controller if not already injected.
    final GraphController controller = Get.put(GraphController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphs",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      drawer: HomeDrawer(context: context),
      body: Obx(() {
        if (controller.expenses.isEmpty) {
          return const Center(child: Text("No expense data available"));
        }

        // Sort expenses by creation date (oldest first)
        final sortedExpenses = List.of(controller.expenses)
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

        // Map expenses to a list of FlSpot.
        final List<FlSpot> dataPoints = [];
        for (int i = 0; i < sortedExpenses.length; i++) {
          dataPoints.add(FlSpot(i.toDouble(), sortedExpenses[i].amount));
        }

        // Determine the maximum y value for chart axis
        final maxY = sortedExpenses
            .map((e) => e.amount)
            .fold<double>(0, (prev, amt) => amt > prev ? amt : prev) +
            5;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index < 0 || index >= sortedExpenses.length) return Container();
                      final date = sortedExpenses[index].createdAt;
                      final formattedDate = "${date.month}/${date.day}";
                      return SideTitleWidget(
                        space: 8,
                        meta: meta,
                        child: Text(formattedDate, style: const TextStyle(fontSize: 10)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              minX: 0,
              maxX: (sortedExpenses.length - 1).toDouble(),
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: dataPoints,
                  isCurved: true,
                  color: Colors.indigo,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
