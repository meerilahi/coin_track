import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required DateTime time,
    required String type,
    required String category,
    required String description,
    required int amount,
  }) : super(
          time: time,
          type: type,
          category: category,
          description: description,
          amount: amount,
        );

  static Map<String, String> toMap(TransactionModel model) {
    return {
      time: model.time.toIso8601String(),
      type: model.type,
      category: model.category,
      description: model.description,
      amount: model.amount.toString(),
    };
  }

  static TransactionModel fromMap(Map<dynamic, dynamic> map) {
    return TransactionModel(
      time: DateTime.parse(map[time]!),
      type: map[type]!,
      category: map[category]!,
      description: map[description]!,
      amount: int.tryParse(map[amount]!) ?? 0,
    );
  }

  static TransactionModel fromEntity(TransactionEntity entity) =>
      TransactionModel(
        time: entity.time,
        type: entity.type,
        category: entity.category,
        description: entity.description,
        amount: entity.amount,
      );
}
