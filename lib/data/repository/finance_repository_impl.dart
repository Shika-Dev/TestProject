import 'dart:convert';

import 'package:test_project/data/datasource/local/finance_datasource_sp.dart';
import 'package:test_project/domain/model/summary_model.dart';
import 'package:test_project/domain/model/transaction_model.dart';
import 'package:test_project/domain/repository/finance_repository_abs.dart';

class FinanceRepository extends AbsFinanceRepository {
  final FinanceSpDatasource _spDatasource;

  FinanceRepository(this._spDatasource);

  @override
  Future<List<TransactionModel>> getAllTransaction(
      [String? date, String? category]) async {
    try {
      String resultJson = _spDatasource.getTransactions();
      List<TransactionModel> result = jsonDecode(resultJson);
      if (date != null) {
        result.removeWhere((element) => element.dateCreated == date);
      }
      if (category != null) {
        result.removeWhere((element) => element.category == category);
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addTransaction(TransactionModel model) async {
    try {
      return true;
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  Future<SummaryModel> getSummery() async {
    return SummaryModel(saldo: 0, total_expense: 0, total_income: 0);
  }
}
