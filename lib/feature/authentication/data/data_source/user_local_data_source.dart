import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> clearAuthToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _authTokenKey = 'AUTH_TOKEN';

  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveAuthToken(String token) async {
    await sharedPreferences.setString(_authTokenKey, token);
  }

  @override
  Future<String?> getAuthToken() async {
    return sharedPreferences.getString(_authTokenKey);
  }

  @override
  Future<void> clearAuthToken() async {
    await sharedPreferences.remove(_authTokenKey);
  }
}
