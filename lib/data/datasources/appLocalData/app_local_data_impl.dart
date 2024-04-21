import 'package:get_storage/get_storage.dart';
import 'app_local_data.dart';

class AppLocalDataImpl extends AppLocalData {
  //This class hold now only for GetStorage, we can configure according to our requirement
  //We can also Use SharedPref instead of GetStorage.

  AppLocalDataImpl._();

  static AppLocalDataImpl? _instance;

  static AppLocalDataImpl getInstance() {
    _instance ??= AppLocalDataImpl._();
    return _instance!;
  }

  final _box = GetStorage(); // only one instance created when invoked from appBinding class

  static const String _userToken = "userToken";

  @override
  Future<String> getToken() async{
    return await _box.read(_userToken) ?? "";
  }

  @override
  void setToken(String? token) {
    _box.write(_userToken, token);
  }

  @override
  Future clearAllData() async{
    final List<String> allKeys = _box.getKeys().toList();
    for (String key in allKeys.toList()) {

        _box.remove(key);

    }
  }
}
