class Repositories {
  final Map<Type, dynamic> _repositories = {};

  void add<T>(final T repository) {
    _repositories[T] = repository;
  }

  T get<T>() {
    final repository = _repositories[T];
    if (repository == null) {
      throw Exception('Repositorio do tipo $T não encontrado');
    }
    return repository;
  }
}
