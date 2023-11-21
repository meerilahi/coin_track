import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/delete_dialog.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsViewMobile extends StatelessWidget {
  const TransactionsViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        context.select<TransactionProvider, List<TransactionEntity>>(
            (value) => value.getTransactions);
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) async {
            return await showDeleteDialog(context);
          },
          onDismissed: (_) async {
            try {
              await context
                  .read<TransactionProvider>()
                  .deleteTransaction(transaction);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Transaction deleted successfully!"),
                ),
              );
            } catch (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Transaction deletion failed!"),
                ),
              );
            }
          },
          background: Container(
            alignment: const Alignment(0.9, 0),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          key: UniqueKey(),
          child: ListTile(
            leading: Icon(
              transaction.type == income
                  ? incomeCategoriesIconsData[transaction.category]
                  : expenseCategoriesIconsData[transaction.category],
              color: Colors.cyan.shade800,
              size: 40,
            ),
            title: Text(
              transaction.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
                "${transaction.time.day} ${monthNames[transaction.time.month]}"),
            trailing: Text(
              transaction.type == income
                  ? "+${transaction.amount}"
                  : "-${transaction.amount}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
    // Center(
    //   child: StreamBuilder<List<TransactionEntity>>(
    //       stream: context.watch<TransactionProvider>().getTransactions,
    //       builder: (context, snapshot) {
    //         switch (snapshot.connectionState) {
    //           case ConnectionState.active:
    //             if (snapshot.hasData) {
    //               if (snapshot.data!.isEmpty) {
    //                 return Text("No Transactions Yet! Click on + to add");
    //               } else {
    //                 final transactions = snapshot.data;
    // return ListView.builder(
    //   itemCount: transactions!.length,
    //   itemBuilder: (context, index) {
    //     final transaction = transactions[index];
    //     return Dismissible(
    //       direction: DismissDirection.endToStart,
    //       confirmDismiss: (_) async {
    //         return await showDeleteDialog(context);
    //       },
    //       onDismissed: (_) async {
    //         try {
    //           await context
    //               .read<TransactionProvider>()
    //               .deleteTransaction(transaction);
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content:
    //                   Text("Transaction deleted successfully!"),
    //             ),
    //           );
    //         } catch (_) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content: Text("Transaction deletion failed!"),
    //             ),
    //           );
    //         }
    //       },
    //       background: Container(
    //         alignment: Alignment(0.9, 0),
    //         color: Colors.red,
    //         child: Icon(
    //           Icons.delete,
    //           color: Colors.white,
    //           size: 30,
    //         ),
    //       ),
    //       key: UniqueKey(),
    //       child: ListTile(
    //         leading: Icon(
    //           transaction.type == "income"
    //               ? incomeCategoriesIconsData[
    //                   transaction.category]
    //               : expenseCategoriesIconsData[
    //                   transaction.category],
    //           color: Colors.cyan.shade800,
    //           size: 40,
    //         ),
    //         title: Text(
    //           transaction.description,
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //         subtitle: Text(
    //             "${transaction.time.day} ${monthNames[transaction.time.month]}"),
    //         trailing: Text(
    //           transaction.type == "income"
    //               ? "+${transaction.amount}"
    //               : "-${transaction.amount}",
    //           style: TextStyle(
    //             fontSize: 20,
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
    //               }
    //             } else {
    //               return Text("Unable to load data");
    //             }

    //           default:
    //             return CircularProgressIndicator();
    //         }
    //       }),
    // );
  }
}
