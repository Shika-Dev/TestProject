class TransactionModel {
  final String desc;
  final String category;
  final num amount;
  final String dateCreated;

  TransactionModel(
      {required this.desc,
      required this.category,
      required this.amount,
      required this.dateCreated});
}
