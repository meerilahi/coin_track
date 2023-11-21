import 'package:flutter/material.dart';

class SideNavBarTab extends StatelessWidget {
  const SideNavBarTab({
    Key? key,
    required this.dashboardCallback,
    required this.transactionCallback,
  }) : super(key: key);

  final void Function() dashboardCallback;
  final void Function() transactionCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.cyan.shade900,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          const Spacer(flex: 2),
          IconButton(
            onPressed: () {
              dashboardCallback();
            },
            icon: const Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
          ),
          const Spacer(flex: 1),
          IconButton(
            onPressed: () {
              transactionCallback();
            },
            icon: const Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          const Spacer(
            flex: 10,
          )
        ],
      ),
    );
  }
}
