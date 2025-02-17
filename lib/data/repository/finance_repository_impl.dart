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
      List<TransactionModel> result = resultModelFromJson(resultJson);
      if (date != null) {
        result.removeWhere((element) => element.dateCreated != date);
      }
      if (category != null) {
        result.removeWhere((element) => element.category != category);
      }
      return result;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> addTransaction(TransactionModel model) async {
    try {
      String resultJson = _spDatasource.getTransactions();
      List<TransactionModel> result = [];
      if(resultJson != ""){
        result = resultModelFromJson(resultJson);
      }
       
      result.add(model);

      return _spDatasource.addTransactions(jsonEncode(result));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SummaryModel> getSummary() async {
    String resultJson = _spDatasource.getTransactions();
    List<TransactionModel> result = resultModelFromJson(resultJson);
    num saldo = result.fold(0, (prevVal, element) {
      if(element.category == "Income"){
        return prevVal + element.amount;
      } else return prevVal - element.amount;
    });
    num total_expense = result.fold(0, (prevVal, element) => element.category == "Income" ? prevVal : prevVal + element.amount);
    num total_income = result.fold(0, (prevVal, element) => element.category == "Expense" ? prevVal : prevVal + element.amount);
    return SummaryModel(saldo: saldo, total_expense: total_expense, total_income: total_income);
  }
}
