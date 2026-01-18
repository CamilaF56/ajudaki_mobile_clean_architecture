class Repositories {
  final Map<Type, dynamic> _repositories = {};

  void add<T>(T repository) {
    _repositories[T] = repository;
  }

  T get<T>() {
    final repository = _repositories[T];
    if (repository == null) {
      throw Exception('Repository for type $T not found');
    }
    return repository;
  }
}
