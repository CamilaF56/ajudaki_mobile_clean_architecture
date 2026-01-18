/// Cliente responsável pela comunicação HTTP com a API backend.
abstract class ApiClient {
  final Map<Type, dynamic> _paths = {};

  /// Método genérico para adicionar um caminho (path).
  void addPath<T>(dynamic path) {
    _paths[T] = path;
  }

  /// Método genérico para obter um caminho (path).
  T getPath<T>() {
    final path = _paths[T];
    if (path == null) {
      throw Exception('Path for type $T not found');
    }
    return path as T;
  }
}
