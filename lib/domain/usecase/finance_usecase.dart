import 'package:test_project/domain/model/summary_model.dart';
import 'package:test_project/domain/model/transaction_model.dart';

abstract class FinanceUsecase {
  Future<List<TransactionModel>> getAllTransaction(
      [String? date, String? category]);
  Future<bool> addTransaction(TransactionModel model);
  Future<SummaryModel> getSummary();
}
