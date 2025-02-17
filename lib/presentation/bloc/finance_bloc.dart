import 'package:equatable/equatable.dart';
import 'package:test_project/domain/model/summary_model.dart';
import 'package:test_project/domain/model/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/domain/usecase/finance_usecase.dart';


part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  final FinanceUsecase usecase;
  FinanceBloc({required this.usecase}) : super(const FinanceState()) {
    on<GetTransaction>(_getTransaction);
    on<GetSummary>(_getSummary);
    on<AddTransaction>(_addTransaction);
  }

  Future<void> _getTransaction(
    GetTransaction event,
    Emitter<FinanceState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FinanceStatus.loading,
      ),
    );
    try {
      final result = await usecase.getAllTransaction(event.date, event.category);

      emit(
        state.copyWith(
          status: FinanceStatus.success,
          transactions: result
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: FinanceStatus.failed, errorMessage: '$e'),
      );
    }
  }

  Future<void> _getSummary(
    GetSummary event,
    Emitter<FinanceState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FinanceStatus.loading,
      ),
    );
    try {
      final result = await usecase.getSummary();

      emit(
        state.copyWith(
          status: FinanceStatus.success,
          summaries: result
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: FinanceStatus.failed, errorMessage: '$e'),
      );
    }
  }

  Future<void> _addTransaction(
    AddTransaction event,
    Emitter<FinanceState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FinanceStatus.loading,
      ),
    );
    try {
      await usecase.addTransaction(event.model);

      emit(
        state.copyWith(
          status: FinanceStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: FinanceStatus.failed, errorMessage: '$e'),
      );
    }
  }
}
