import 'dart:convert';
import '../result.dart';
import 'web_result_status_type.dart';

/// Classe que representa uma resposta de uma API web.
///
/// Contém o código HTTP bruto, o JSON original como string
/// e o corpo convertido para o tipo [T].
class WebResult<T> extends Result<T> {
  WebResult(
    this.statusCode, [
    this.body,
    final T Function(Map<String, dynamic> json)? fromJson
  ])  : statusType = _resolveStatusType(statusCode),
        super(
          _resolveStatusType(statusCode) == WebResultStatusType.success,
          _convertBody(body, fromJson)
        );

  final int statusCode;
  final WebResultStatusType statusType;
  final String? body;

  static T? _convertBody<T>(
    final String? bodyString,
    final T Function(Map<String, dynamic> json)? fromJson,
  ) {
    if (bodyString == null || fromJson == null) {
      return null;
    }

    final decoded = jsonDecode(bodyString);

    if (decoded is Map<String, dynamic>) {
      return fromJson(decoded);
    }

    throw FormatException(
      'Erro de formato - esperava um objeto JSON para conversão em $T',
    );
  }

  /// Resolve o tipo da resposta HTTP com base no código.
  static WebResultStatusType _resolveStatusType(final int code) {
    if (code >= 100 && code < 200) {
      return WebResultStatusType.informational;
    }
    if (code >= 200 && code < 300) {
      return WebResultStatusType.success;
    }
    if (code >= 300 && code < 400) {
      return WebResultStatusType.redirection;
    }
    if (code >= 400 && code < 500) {
      return WebResultStatusType.clientError;
    }
    if (code >= 500 && code < 600) {
      return WebResultStatusType.serverError;
    }
    return WebResultStatusType.unknown;
  }
}
