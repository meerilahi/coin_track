import 'package:coin_track/features/expense_tracking/presentation/widgets/expense_summary_widget.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/income_expense_variation_summary_widget.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/income_summary_widget.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/report_widget.dart';
import 'package:flutter/material.dart';

class DashboardViewMobile extends StatelessWidget {
  const DashboardViewMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20),
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
            const ExpenseSummaryWidget(),
            const SizedBox(height: 20),
            const IncomeSummaryWidget(),
            const SizedBox(height: 20),
            const IncomeExpenseVariationSummaryWidget(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
