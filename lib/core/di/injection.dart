import 'package:get_it/get_it.dart';
import 'package:test_payment_app/core/secure_storage/data/datasources/secure_storage_local_data_source.dart';
import 'package:test_payment_app/core/secure_storage/data/datasources/secure_storage_local_data_source_impl.dart';
import 'package:test_payment_app/core/secure_storage/data/repositories/secure_storage_repository_impl.dart';
import 'package:test_payment_app/core/secure_storage/domain/repositories/secure_storage_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<SecureStorageLocalDataSource>(
    SecureStorageLocalDataSourceImpl.new,
  );

  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepositoryImpl(getIt<SecureStorageLocalDataSource>()),
  );
}
