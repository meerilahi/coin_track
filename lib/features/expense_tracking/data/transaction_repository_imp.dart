import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_track/features/expense_tracking/data/transaction_model.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_repository.dart';

class TransactionRepositoryImp implements TransactionRepository {
  final String _userId;
  final _db = FirebaseFirestore.instance;

  TransactionRepositoryImp(this._userId);

  @override
  Future<void> addTransaction(TransactionEntity transactionEntity) async {
    final model = TransactionModel.fromEntity(transactionEntity);
    final map = TransactionModel.toMap(model);
    await _db.collection(_userId).doc(model.time.toIso8601String()).set(map);
  }

  @override
  Future<void> deleteTransaction(TransactionEntity transactionEntity) async {
    final model = TransactionModel.fromEntity(transactionEntity);
    await _db.collection(_userId).doc(model.time.toIso8601String()).delete();
  }

  List<TransactionModel> _querySnapshotsToListOfTransactionModel(
      QuerySnapshot<Map<String, dynamic>> querySnapshots) {
    return querySnapshots.docs.map(
      (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        return TransactionModel.fromMap(
          documentSnapshot.data(),
        );
      },
    ).toList();
  }

  @override
  Stream<List<TransactionEntity>> get getTransactions {
    return _db
        .collection(_userId)
        .snapshots()
        .map(_querySnapshotsToListOfTransactionModel)
        .asBroadcastStream();
  }
}
