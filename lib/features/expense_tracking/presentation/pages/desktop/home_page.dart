// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coin_track/features/expense_tracking/presentation/widgets/side_navigation_bar_desktop.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/side_navigation_bar_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:coin_track/features/expense_tracking/presentation/pages/desktop/dashboard_view.dart';
import 'package:coin_track/features/expense_tracking/presentation/pages/desktop/transactions_view.dart';
import 'package:coin_track/features/expense_tracking/presentation/widgets/new_transaction_dialog.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  int index = 0;

  @override
  void initState() {
    context.read<TransactionProvider>().setupStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(index == 0 ? "Dashboard" : "Transactions"),
          centerTitle: true,
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
        body: Row(
          children: [
            const SizedBox(width: 2),
            size.width <= 1000
                ? SideNavBarTab(
                    dashboardCallback: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    transactionCallback: () {
                      setState(() {
                        index = 1;
                      });
                    },
                  )
                : SideNavBarDesktop(
                    dashboardCallback: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    transactionCallback: () {
                      setState(() {
                        index = 1;
                      });
                    },
                  ),
            const Spacer(flex: 1),
            index == 0
                ? const DashboardViewDesktop()
                : const TransactionsViewDesktop(),
            const Spacer(flex: 1),
          ],
        ),
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
      ),
    );
  }
}
