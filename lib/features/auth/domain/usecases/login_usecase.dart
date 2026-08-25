import 'package:e_commerce_test/features/auth/domain/entities/auth_response_entity.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<LoginResponseEntity> call({
    required String userName,
    required String password,
  }) {
    return _repository.login(
      userName: userName,
      password: password,
    );
  }
}