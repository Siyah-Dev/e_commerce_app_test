import 'package:e_commerce_test/core/network/dio_provider.dart';
import 'package:e_commerce_test/features/home/presentation/controllers/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../controllers/home_controller.dart';



final homeRemoteDataSourceProvider =
    Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSource(
    ref.watch(dioProvider),
  );
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    ref.watch(homeRemoteDataSourceProvider),
  );
});

final homeControllerProvider =
    NotifierProvider<HomeController, HomeState>(
  HomeController.new,
);