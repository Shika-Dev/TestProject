
import 'package:get_it/get_it.dart';
import 'package:test_project/domain/usecase/finance_usecase.dart';
import 'package:test_project/presentation/bloc/finance_bloc.dart';

class BlocModule {
  static void provide() {
    GetIt getIt = GetIt.instance;
    getIt.registerFactory<FinanceBloc>(
      () => FinanceBloc(
          usecase: GetIt.instance<FinanceUsecase>()),
    );
  }
}
