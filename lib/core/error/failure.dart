sealed class Failure {
  const Failure();
}

final class SecureStorageFailure extends Failure {
  const SecureStorageFailure(this.message);

  final String message;
}
