import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummaryWidget extends StatelessWidget {
  const ExpenseSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseSummaryChartData =
        context.select<TransactionProvider, Map<String, double>>(
            (provider) => provider.expenseSummaryChartData);
    final size = MediaQuery.of(context).size;

    final circleDiameter = size.width <= 400
        ? 180
        : size.width <= 700
            ? 220
            : size.width <= 900
                ? 180
                : size.width <= 1000
                    ? 250
                    : size.width <= 1300
                        ? 180
                        : 300;

    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.width <= 900 ? 320 : 400,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: 15),
                child: Text(
                  expense,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: expenseSummaryChartData.keys
                      .map(
                        (category) => Row(
                          children: [
                            Icon(
                              expenseCategoriesIconsData[category],
                              color: expenseCategoriesColorsData[category],
                            ),
                            Text(category)
                          ],
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  width: circleDiameter.toDouble(),
                  height: circleDiameter.toDouble(),
                  child: expenseSummaryChartData.isEmpty
                      ? const Center(child: Text("No Data"))
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: true),
                              centerSpaceRadius: 5,
                              sectionsSpace: 3,
                              sections: expenseSummaryChartData.keys
                                  .map(
                                    (category) => PieChartSectionData(
                                      borderSide: const BorderSide(
                                          color: Colors.black38),
                                      value: expenseSummaryChartData[category],
                                      color:
                                          expenseCategoriesColorsData[category],
                                      radius: circleDiameter / 2,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
