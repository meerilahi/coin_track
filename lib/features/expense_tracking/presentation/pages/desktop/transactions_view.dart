import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/domain/table_transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/delete_dialog.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsViewDesktop extends StatefulWidget {
  const TransactionsViewDesktop({super.key});

  @override
  State<TransactionsViewDesktop> createState() =>
      _TransactionsViewDesktopState();
}

class _TransactionsViewDesktopState extends State<TransactionsViewDesktop> {
  @override
  Widget build(BuildContext context) {
    final transactions =
        context.select<TransactionProvider, List<TableTransactionEntity>>(
            (value) => value.getTableTransactions);
    final size = MediaQuery.of(context).size;
    final columnSpace = size.width <= 900
        ? 3
        : size.width <= 1100
            ? 10
            : size.width <= 1300
                ? 40
                : size.width <= 1600
                    ? 75
                    : 120;
    final maxTextWidth = size.width <= 900
        ? 70
        : size.width <= 1000
            ? 90
            : size.width <= 1300
                ? 110
                : size.width <= 1600
                    ? 180
                    : 240;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  showCheckboxColumn: true,
                  dataRowMaxHeight: double.infinity,
                  columnSpacing: columnSpace.toDouble(),
                  headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      return Colors.cyan.shade900;
                    },
                  ),
                  columns: const [
                    DataColumn(
                        label: Text(
                          "No.",
                          style: TextStyle(color: Colors.white),
                        ),
                        numeric: true),
                    DataColumn(
                      label: Text(
                        "Description.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Category.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Type",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Date",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                          "Amount",
                          style: TextStyle(color: Colors.white),
                        ),
                        numeric: true),
                  ],
                  rows: transactions
                      .map(
                        (transaction) => DataRow(
                          selected: transaction.isSelected,
                          onSelectChanged: (value) {
                            context
                                .read<TransactionProvider>()
                                .changeSelection(transaction, value!);
                            int index = transactions.indexOf(transaction);
                            transactions[index].isSelected = value;
                            setState(() {});
                          },
                          cells: [
                            DataCell(
                              Text("${transactions.indexOf(transaction) + 1}"),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: maxTextWidth.toDouble(),
                                ),
                                child: Text(transaction.description),
                              ),
                            ),
                            DataCell(
                              Text(
                                transaction.category,
                              ),
                            ),
                            DataCell(
                              Text(transaction.type),
                            ),
                            DataCell(
                              Text(
                                "${transaction.time.day}-${monthNames[transaction.time.month]}-${transaction.time.year}",
                              ),
                            ),
                            DataCell(
                              Text(transaction.amount.toString()),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            if (transactions.any((transaction) => transaction.isSelected))
              TextButton.icon(
                onPressed: () async {
                  bool? confirm = await showDeleteDialog(context);
                  if (confirm == true) {
                    try {
                      await context
                          .read<TransactionProvider>()
                          .deleteSelectedTransactions();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Transactions deleted successfully"),
                        ),
                      );
                    } catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Deletion failed")),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
              )
          ],
        ),
      ),
    );
  }
}
