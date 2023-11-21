class TransactionEntity {
  final DateTime time;
  final String type;
  final String category;
  final String description;
  final int amount;

  TransactionEntity({
    required this.time,
    required this.type,
    required this.category,
    required this.description,
    required this.amount,
  });

  @override
  String toString() {
    return 'Transaction(time: $time, type: $type, category: $category, description: $description, amount: $amount)';
  }

  @override
  bool operator ==(covariant TransactionEntity other) {
    if (identical(this, other)) return true;

    return other.time == time;
  }

  @override
  int get hashCode {
    return time.hashCode;
  }
}
