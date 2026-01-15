/// Representa o resultado de uma operação.
///
/// Pode ser um sucesso, contendo um valor do tipo [T],
/// ou um erro, contendo uma exceção.
sealed class Response<T> {
  /// Construtor base da resposta.
  const Response();

  /// Cria uma resposta de sucesso contendo o valor retornado.
  const factory Response.success(final T value) = Success._;

  /// Cria uma resposta de erro contendo a exceção ocorrida.
  const factory Response.error(final Exception error) = Error._;
}

/// Representa uma resposta de sucesso.
final class Success<T> extends Response<T> {
  /// Cria uma resposta de sucesso com o valor informado.
  const Success._(this.value);

  /// Valor retornado pela operação.
  final T value;

  @override
  String toString() => 'Response<$T>.success($value)';
}

/// Representa uma resposta de erro.
final class Error<T> extends Response<T> {
  /// Cria uma resposta de erro com a exceção informada.
  const Error._(this.error);

  /// Exceção que descreve o erro ocorrido.
  final Exception error;

  @override
  String toString() => 'Response<$T>.error($error)';
}
