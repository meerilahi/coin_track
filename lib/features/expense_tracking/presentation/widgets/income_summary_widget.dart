import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeSummaryWidget extends StatelessWidget {
  const IncomeSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeSummaryChartData =
        context.select<TransactionProvider, Map<String, double>>(
            (provider) => provider.incomeSummaryChartData);
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.width <= 900 ? 320 : 400,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                income,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: incomeSummaryChartData.isEmpty
                  ? const Center(child: Text("No Data"))
                  : BarChart(
                      BarChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 25,
                            getTitlesWidget: (value, meta) {
                              String category = incomeSummaryChartData.keys
                                  .toList()[value.floor()];
                              IconData iconData =
                                  incomeCategoriesIconsData[category]!;
                              Color color =
                                  incomeCategoriesColorsData[category]!;
                              return Icon(
                                iconData,
                                color: color,
                              );
                            },
                          )),
                        ),
                        borderData: FlBorderData(
                          border: const Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none,
                            bottom: BorderSide(
                              width: 1,
                            ),
                          ),
                        ),
                        barGroups: incomeSummaryChartData.keys.map((category) {
                          final index = incomeSummaryChartData.keys
                              .toList()
                              .indexOf(category);
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: incomeSummaryChartData[category]!,
                                width: 25,
                                borderRadius: BorderRadius.circular(2),
                                color: incomeCategoriesColorsData[category],
                                borderSide:
                                    const BorderSide(color: Colors.black38),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
