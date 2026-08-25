import 'package:e_commerce_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_test/features/auth/domain/entities/auth_response_entity.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<LoginResponseEntity> login({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.login(
      email: email,
      password: password,
    );
  }
}