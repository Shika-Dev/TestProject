import 'package:get_it/get_it.dart';
import 'package:test_project/data/datasource/local/finance_datasource_sp.dart';
import 'package:test_project/data/repository/finance_repository_impl.dart';

class RepositoryModule {
  static void provide() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<FinanceRepository>(
        FinanceRepository(GetIt.instance<FinanceSpDatasource>()));
  }
}
