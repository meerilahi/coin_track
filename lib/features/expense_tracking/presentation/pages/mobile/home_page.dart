import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:coin_track/features/expense_tracking/presentation/pages/mobile/dashboard_view.dart';
import 'package:coin_track/features/expense_tracking/presentation/pages/mobile/transactions_view.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/new_transaction_dialog.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int index = 0;

  @override
  void initState() {
    context.read<TransactionProvider>().setupStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(index == 0 ? "Dashboard" : "Transactions"),
          actions: [
            if (index == 0)
              DropdownButton(
                icon: const Icon(
                  Icons.filter_alt,
                ),
                value: context.select<TransactionProvider, String>(
                    (provider) => provider.filter),
                items: const [
                  DropdownMenuItem(
                    value: allTimes,
                    child: Text(allTimes),
                  ),
                  DropdownMenuItem(
                    value: lastMonth,
                    child: Text(lastMonth),
                  ),
                  DropdownMenuItem(
                    value: lastWeek,
                    child: Text(lastWeek),
                  ),
                ],
                onChanged: (value) {
                  context.read<TransactionProvider>().filter = value;
                },
              ),
            PopupMenuButton(
              iconSize: 40,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text("Setting"),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: const Text("Logout"),
                  onTap: () async {
                    await context.read<AuthProvider>().singOut();
                  },
                ),
              ],
            ),
          ],
        ),
        body: index == 0
            ? const DashboardViewMobile()
            : const TransactionsViewMobile(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const NewTransactionDialog();
                },
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(Icons.add),
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
          ],
        ),
      ),
    );
  }
}
