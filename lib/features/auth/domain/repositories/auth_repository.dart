import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String mail, String password);
  Future<User> register(String mail, String password, String name);
  Future<User> checkAuthStatus(String token);
}
