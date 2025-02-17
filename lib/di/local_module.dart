import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/data/datasource/local/finance_datasource_sp.dart';

class LocalModule {
  static Future <void> provide() async {
    GetIt getIt = GetIt.instance;
    SharedPreferences sp = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sp);
    getIt.registerSingleton<FinanceSpDatasource>(
        FinanceSpDatasource(GetIt.I<SharedPreferences>()));
  }
}
