import 'package:flutter/material.dart';

Future<bool?> showDeleteDialog(BuildContext context) async {
  bool? delete;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure to delete this transaction"),
      actions: [
        TextButton(
            onPressed: () {
              delete = false;
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            delete = true;
            Navigator.pop(context);
          },
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
  return delete;
}
