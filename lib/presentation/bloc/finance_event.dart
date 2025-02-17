part of 'finance_bloc.dart';

abstract class FinanceEvent extends Equatable {
  const FinanceEvent();

  @override
  List<Object> get props => [];
}

class GetTransaction extends FinanceEvent {
  final String? date;
  final String? category;

  const GetTransaction({
    this.date, this.category
  });
}

class GetSummary extends FinanceEvent {}

class AddTransaction extends FinanceEvent {
  final TransactionModel model;

  const AddTransaction({
    required this.model
  });
}