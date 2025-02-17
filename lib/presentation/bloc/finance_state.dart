part of 'finance_bloc.dart';

enum FinanceStatus { initial, loading, success, failed }

class FinanceState extends Equatable {
  const FinanceState({
    this.status = FinanceStatus.initial,
    this.transactions = const <TransactionModel>[],
    this.summaries,
    this.errorMessage = ''
  });

  final FinanceStatus status;
  final List<TransactionModel> transactions;
  final String errorMessage;
  final SummaryModel? summaries;

  FinanceState copyWith({
    FinanceStatus? status,
    List<TransactionModel>? transactions,
    String? errorMessage,
    SummaryModel? summaries
  }) {
    return FinanceState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      summaries: summaries ?? this.summaries,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        summaries,
        errorMessage
      ];
}