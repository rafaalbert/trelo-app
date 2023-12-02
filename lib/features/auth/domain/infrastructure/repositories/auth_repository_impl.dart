import 'package:teslo_shop/features/auth/domain/domain.dart';

import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource,
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String mail, String password) {
    return dataSource.login(mail, password);
  }

  @override
  Future<User> register(String mail, String password, String name) {
    return dataSource.register(mail, password, name);
  }
}
