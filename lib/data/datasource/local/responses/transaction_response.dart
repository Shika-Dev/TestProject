class TransactionResponse {
  final String desc;
  final String category;
  final num amount;
  final String dateCreated;

  TransactionResponse(
      {required this.desc,
      required this.category,
      required this.amount,
      required this.dateCreated});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
          desc: json['desc'],
          category: json['category'],
          amount: json['amount'],
          dateCreated: json['dateCreated']);
}
