import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/core/locale/app_language.dart';

abstract interface class LanguageRepository {
  Stream<AppLanguage> watchLanguage();

  Future<Either<Failure, void>> setLanguage(AppLanguage language);

  Future<Either<Failure, void>> clearLanguage();
}
