import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transactionEntity);
  Future<void> deleteTransaction(TransactionEntity transactionEntity);
  Stream<List<TransactionEntity>> get getTransactions;
}
