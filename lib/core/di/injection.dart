import 'package:get_it/get_it.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/secure_storage/data/datasources/secure_storage_local_data_source.dart';
import 'package:test_payment_app/core/secure_storage/data/datasources/secure_storage_local_data_source_impl.dart';
import 'package:test_payment_app/core/secure_storage/data/repositories/secure_storage_repository_impl.dart';
import 'package:test_payment_app/core/secure_storage/domain/repositories/secure_storage_repository.dart';
import 'package:test_payment_app/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:test_payment_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:test_payment_app/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:test_payment_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:test_payment_app/features/subscription/data/repositories/subscription_plan_repository_impl.dart';
import 'package:test_payment_app/features/subscription/domain/repositories/subscription_plan_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<SecureStorageLocalDataSource>(
    SecureStorageLocalDataSourceImpl.new,
  );

  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepositoryImpl(getIt<SecureStorageLocalDataSource>()),
  );

  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt<SecureStorageRepository>()),
  );

  getIt.registerLazySingleton<SubscriptionPlanRepository>(
    () => SubscriptionPlanRepositoryImpl(getIt<SecureStorageRepository>()),
  );

  getIt.registerLazySingleton<PaymentRepository>(
    () => const PaymentRepositoryImpl(),
  );

  getIt.registerLazySingleton<AppBloc>(
    () => AppBloc(
      onboardingRepository: getIt<OnboardingRepository>(),
      subscriptionPlanRepository: getIt<SubscriptionPlanRepository>(),
    ),
  );
}
