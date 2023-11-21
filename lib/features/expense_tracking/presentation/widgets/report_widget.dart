// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final reportData = context.select<TransactionProvider, Map<String, int>>(
      (provider) {
        return provider.reportWidgetData;
      },
    );
    return Wrap(
      children: [
        ReportCard(
          title: balance,
          amount: reportData[balance] != null
              ? reportData[balance].toString()
              : "0",
          color: Colors.cyan.shade900,
        ),
        ReportCard(
          title: transactionsNo,
          amount: reportData[transactionsNo] != null
              ? reportData[transactionsNo].toString()
              : "0",
          color: Colors.cyan.shade900,
        ),
        ReportCard(
          title: expense,
          amount: reportData[expense] != null
              ? reportData[expense].toString()
              : "0",
          color: Colors.red,
        ),
        ReportCard(
          title: income,
          amount:
              reportData[income] != null ? reportData[income].toString() : "0",
          color: Colors.green,
        ),
      ],
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.color,
  }) : super(key: key);

  final String title;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 160,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
