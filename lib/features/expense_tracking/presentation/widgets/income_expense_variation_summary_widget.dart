import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/domain/variation_data_entity.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeExpenseVariationSummaryWidget extends StatefulWidget {
  const IncomeExpenseVariationSummaryWidget({
    super.key,
  });

  @override
  State<IncomeExpenseVariationSummaryWidget> createState() =>
      _IncomeExpenseVariationSummaryWidgetState();
}

class _IncomeExpenseVariationSummaryWidgetState
    extends State<IncomeExpenseVariationSummaryWidget> {
  bool isSteped = false;

  @override
  Widget build(BuildContext context) {
    final variationDataList =
        context.select<TransactionProvider, List<VariationData>>(
            (provider) => provider.incomeExpenseVariationChartData);
    final filter = context
        .select<TransactionProvider, String>((provider) => provider.filter);
    final list = List.generate(variationDataList.length, (index) => index);
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: size.width <= 900 ? 320 : 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              alignment: const Alignment(-0.8, 0),
              child: Row(
                children: [
                  const Text(
                    "Time Lapse",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSteped = !isSteped;
                      });
                    },
                    icon: Icon(
                      Icons.stacked_bar_chart_sharp,
                      color: Colors.cyan.shade900,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: variationDataList.isEmpty
                  ? const Center(child: Text("No Data"))
                  : LineChart(
                      LineChartData(
                        minY: 0,
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(
                          border: Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            bottom: BorderSide(
                                color: Colors.cyan.shade800, width: 3),
                            left: BorderSide(
                                color: Colors.cyan.shade800, width: 3),
                          ),
                        ),
                        titlesData: FlTitlesData(
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: filter == allTimes
                                ? const Text("Months of last year")
                                : filter == lastMonth
                                    ? const Text("Days of last month")
                                    : const Text("Days of last week"),
                            sideTitles: const SideTitles(showTitles: false),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            isStepLineChart: isSteped,
                            preventCurveOverShooting: true,
                            isCurved: true,
                            spots: list
                                .map(
                                  (index) => FlSpot(
                                    index.toDouble(),
                                    variationDataList[index].expense.toDouble(),
                                  ),
                                )
                                .toList(),
                            color: Colors.red,
                            dotData: const FlDotData(show: false),
                          ),
                          LineChartBarData(
                            isStepLineChart: isSteped,
                            preventCurveOverShooting: true,
                            isCurved: true,
                            spots: list
                                .map(
                                  (index) => FlSpot(
                                    index.toDouble(),
                                    variationDataList[index].income.toDouble(),
                                  ),
                                )
                                .toList(),
                            color: Colors.green,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
