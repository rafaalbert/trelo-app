import '../entities/user.dart';

abstract class AuthDataSource {
  Future<User> login(String mail, String password);
  Future<User> register(String mail, String password, String name);
  Future<User> checkAuthStatus(String token);
}
