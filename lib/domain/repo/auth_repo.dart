abstract class AuthRepo{
  Future postLogin({requestData});

  Future clearAllData();

  void setToken(String value);

  Future<String> getToken();
}