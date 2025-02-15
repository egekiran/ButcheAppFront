class Transaction {
  final String transactionId;
  final double amount;
  final String description;
  final String category;
  final String transactionType;
  final DateTime transactionDate;

  Transaction({
    required this.transactionId,
    required this.amount,
    required this.description,
    required this.category,
    required this.transactionType,
    required this.transactionDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transactionId'],
      amount: json['amount'].toDouble(),
      description: json['description'],
      category: json['category'],
      transactionType: json['transactionType'],
      transactionDate: DateTime.parse(json['transactionDate']),
    );
  }
}
