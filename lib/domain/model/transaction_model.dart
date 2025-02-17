import 'dart:convert';

List<TransactionModel> resultModelFromJson(String str) => List<TransactionModel>.from(json.decode(str).map((x) => TransactionModel.fromJson(x)));

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

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          desc: json['desc'],
          category: json['category'],
          amount: json['amount'],
          dateCreated: json['dateCreated']);

  Map<String, dynamic> toJson() => {
    'desc': this.desc,
    'category': this.category,
    'amount': this.amount,
    'dateCreated': this.dateCreated
  };
}
