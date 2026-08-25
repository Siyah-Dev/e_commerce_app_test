import 'package:e_commerce_test/core/network/dio_provider.dart';
import 'package:e_commerce_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    ref.read(dioProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(
    ref.read(authRepositoryProvider),
  );
});