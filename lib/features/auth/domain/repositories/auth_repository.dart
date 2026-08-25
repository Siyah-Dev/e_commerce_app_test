import 'package:e_commerce_test/features/auth/domain/entities/auth_response_entity.dart';


abstract class AuthRepository {
  Future<LoginResponseEntity> login({
    required String email,
    required String password,
  });
}