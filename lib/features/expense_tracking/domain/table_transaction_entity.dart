import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';

class TableTransactionEntity extends TransactionEntity {
  bool isSelected = false;

  TableTransactionEntity({
    required super.time,
    required super.type,
    required super.category,
    required super.description,
    required super.amount,
  });

  static TableTransactionEntity fromTransactionEntity(
          TransactionEntity transactionEntity) =>
      TableTransactionEntity(
        time: transactionEntity.time,
        type: transactionEntity.type,
        category: transactionEntity.category,
        description: transactionEntity.description,
        amount: transactionEntity.amount,
      );
  static TransactionEntity toTransactionEntity(
          TableTransactionEntity tableTransactionEntity) =>
      TransactionEntity(
        time: tableTransactionEntity.time,
        type: tableTransactionEntity.type,
        category: tableTransactionEntity.category,
        description: tableTransactionEntity.description,
        amount: tableTransactionEntity.amount,
      );
}
