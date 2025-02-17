import 'package:get_it/get_it.dart';
import 'package:test_project/data/repository/finance_repository_impl.dart';
import 'package:test_project/domain/usecase/finance_interactor.dart';
import 'package:test_project/domain/usecase/finance_usecase.dart';

class DomainModule {
  static void provide() {
    GetIt getIt = GetIt.instance;

    getIt.registerSingleton<FinanceUsecase>(
        FinanceInteractor(GetIt.instance<FinanceRepository>()));
  }
}
