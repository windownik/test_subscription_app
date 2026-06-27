abstract interface class SecureStorageLocalDataSource {
  Stream<String?> watch(String key);

  Future<void> write({required String key, required String value});

  Future<void> delete({required String key});
}
