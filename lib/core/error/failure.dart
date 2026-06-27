sealed class Failure {
  const Failure();
}

final class SecureStorageFailure extends Failure {
  const SecureStorageFailure(this.message);

  final String message;
}

final class PaymentFailure extends Failure {
  const PaymentFailure(this.message);

  final String message;
}

final class TariffPlansFailure extends Failure {
  const TariffPlansFailure(this.message);

  final String message;
}
