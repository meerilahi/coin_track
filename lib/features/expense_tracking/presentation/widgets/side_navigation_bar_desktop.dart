import 'package:flutter/material.dart';

class SideNavBarDesktop extends StatelessWidget {
  const SideNavBarDesktop({
    Key? key,
    required this.dashboardCallback,
    required this.transactionCallback,
  }) : super(key: key);

  final void Function() dashboardCallback;
  final void Function() transactionCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        top: 10,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
          color: Colors.cyan.shade900, borderRadius: BorderRadius.circular(20)),
      width: 250,
      height: double.infinity,
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              "Welcome To Coin Track!",
              style: TextStyle(color: Colors.white, fontSize: 32),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          TextButton.icon(
            onPressed: () {
              dashboardCallback();
            },
            icon: const Icon(
              Icons.dashboard,
              color: Colors.white,
              size: 24,
            ),
            label: const Text(
              "Dashbaord",
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () {
              transactionCallback();
            },
            icon: const Icon(
              Icons.list,
              color: Colors.white,
              size: 24,
            ),
            label: const Text(
              "Transactions",
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
        ],
      ),
    );
  }
}
