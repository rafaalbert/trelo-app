import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/domain/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/auth/domain/infrastructure/mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String mail, String password) async {
    try {
      final response = await dio.post('auth/login', data: {
        'email': mail,
        'password': password,
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredentials();
      if (e.type == DioExceptionType.connectionTimeout)
        throw ConnectionTimeout();
      throw CustomError("Algo salio mal", 1);
    } catch (e) {
      throw CustomError("Algo salio mal", 1);
    }
  }

  @override
  Future<User> register(String mail, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
