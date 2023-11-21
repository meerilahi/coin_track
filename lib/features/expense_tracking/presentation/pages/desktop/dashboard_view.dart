import 'package:coin_track/features/expense_tracking/presentation/widgets/expense_summary_widget.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/income_expense_variation_summary_widget.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/income_summary_widget.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/report_widget.dart';
import 'package:flutter/material.dart';

class DashboardViewDesktop extends StatelessWidget {
  const DashboardViewDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 150,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ReportWidget(),
            const SizedBox(height: 20),
            Text(
              "Summary Reports",
              style: TextStyle(
                fontSize: 22,
                color: Colors.cyan.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: const ExpenseSummaryWidget(),
                  ),
                ),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: const IncomeSummaryWidget(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: const IncomeExpenseVariationSummaryWidget(),
            )
          ],
        ),
      ),
    );
  }
}
