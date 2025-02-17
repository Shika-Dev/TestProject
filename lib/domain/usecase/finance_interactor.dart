import 'package:test_project/domain/model/summary_model.dart';
import 'package:test_project/domain/model/transaction_model.dart';
import 'package:test_project/domain/repository/finance_repository_abs.dart';
import 'package:test_project/domain/usecase/finance_usecase.dart';

class FinanceInteractor extends FinanceUsecase {
  final AbsFinanceRepository _financeRepository;

  FinanceInteractor(this._financeRepository);

  @override
  Future<List<TransactionModel>> getAllTransaction(
          [String? date, String? category]) async =>
      await _financeRepository.getAllTransaction(date, category);

  @override
  Future<bool> addTransaction(TransactionModel model) async =>
      await _financeRepository.addTransaction(model);

  @override
  Future<SummaryModel> getSummary() async =>
      await _financeRepository.getSummary();
}
