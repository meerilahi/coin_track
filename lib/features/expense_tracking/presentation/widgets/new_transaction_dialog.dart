// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';

class NewTransactionDialog extends StatefulWidget {
  const NewTransactionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTransactionDialog> createState() => _NewTransactionDialogState();
}

class _NewTransactionDialogState extends State<NewTransactionDialog> {
  TransactionEntity? transaction;

  int typeValue = 0;
  String category = miscellaneous;
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Size size;
    if (screenSize.width >= 1500) {
      size = Size(screenSize.width * 0.2, screenSize.height * 0.7);
    } else if (screenSize.width >= 1000) {
      size = Size(screenSize.width * 0.3, screenSize.height * 0.7);
    } else if (screenSize.width >= 500) {
      size = Size(screenSize.width * 0.6, screenSize.height * 0.7);
    } else if (screenSize.width >= 400) {
      size = Size(screenSize.width * 0.8, screenSize.height * 0.7);
    } else {
      size = Size(screenSize.width, screenSize.height * 0.7);
    }
    return Dialog(
      insetPadding: const EdgeInsets.only(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text(
              "New Transaction",
              style: TextStyle(
                color: Colors.cyan.shade900,
                fontSize: 24,
              ),
            ),
            const Spacer(flex: 2),
            Row(
              children: [
                const Spacer(),
                Radio(
                  value: 0,
                  groupValue: typeValue,
                  onChanged: (newValue) {
                    setState(() {
                      typeValue = newValue!;
                      category = miscellaneous;
                    });
                  },
                ),
                const Text(expense),
                const Spacer(),
                Radio(
                  value: 1,
                  groupValue: typeValue,
                  onChanged: (newValue) {
                    setState(() {
                      typeValue = newValue!;
                      category = miscellaneous;
                    });
                  },
                ),
                const Text(income),
                const Spacer(flex: 2)
              ],
            ),
            const Spacer(flex: 1),
            Row(
              children: [
                const Text("Chose category"),
                const Spacer(),
                DropdownButton(
                  value: category,
                  items: typeValue == 0
                      ? expenseCategoriesIconsData.keys
                          .map(
                            (category) => DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: [
                                    Icon(
                                      expenseCategoriesIconsData[category],
                                      color: Colors.cyan.shade800,
                                    ),
                                    Text(
                                      category,
                                    ),
                                  ],
                                )),
                          )
                          .toList()
                      : incomeCategoriesIconsData.keys
                          .map(
                            (category) => DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: [
                                    Icon(
                                      incomeCategoriesIconsData[category],
                                      color: Colors.cyan.shade700,
                                    ),
                                    Text(
                                      category,
                                    ),
                                  ],
                                )),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      category = value as String;
                    });
                  },
                ),
              ],
            ),
            const Spacer(flex: 1),
            TextField(
              controller: _descriptionController,
              minLines: null,
              maxLines: null,
              decoration: const InputDecoration(hintText: "Add description"),
            ),
            const Spacer(flex: 2),
            Row(
              children: [
                const Text("Amount", style: TextStyle(fontSize: 16)),
                const Spacer(),
                Expanded(
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.attach_money),
                    ),
                    controller: _amountController,
                  ),
                ),
              ],
            ),
            const Spacer(flex: 1),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then((value) {
                    dateTime = value ?? dateTime;
                    return dateTime;
                  });
                  setState(() {});
                },
                icon: const Icon(Icons.calendar_month_outlined),
                label:
                    Text("${dateTime.day}-${dateTime.month}-${dateTime.year}"),
              ),
            ),
            const Spacer(flex: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_descriptionController.text.isNotEmpty &&
                          _amountController.text.isNotEmpty) {
                        final transaction = TransactionEntity(
                          time: dateTime,
                          type: typeValue == 0 ? expense : income,
                          category: category,
                          description: _descriptionController.text,
                          amount: int.parse(_amountController.text),
                        );
                        try {
                          await context
                              .read<TransactionProvider>()
                              .addTransaction(transaction);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Transaction recorded successfully!",
                              ),
                            ),
                          );
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Transaction recording failed!"),
                            ),
                          );
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save")),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
