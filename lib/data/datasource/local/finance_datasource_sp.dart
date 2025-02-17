import 'package:shared_preferences/shared_preferences.dart';

class FinanceSpDatasource {
  SharedPreferences _sp;

  FinanceSpDatasource(this._sp);

  static String listTransaction = 'transactions';

  Future<bool> addTransactions(String transactions) async {
    try {
      await _sp.setString(listTransaction, transactions);
      return true;
    } catch (e) {
      throw e;
    }
  }

  String getTransactions() {
    return _sp.getString(listTransaction) ?? '';
  }
}
