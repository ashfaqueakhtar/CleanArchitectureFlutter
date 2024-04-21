
abstract class AppLocalData{
  void setToken(String? token);

  Future<String> getToken();

  Future clearAllData();
}