import 'dart:convert';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/web/web_response_status_type.dart';

/// Classe base selada que representa uma resposta de uma API web.
///
/// Contém o código HTTP bruto, o JSON original como string
/// e o corpo convertido para o tipo [T].
class WebResponse<T> extends Response<T> {
  final int statusCode;
  final WebResponseStatusType statusType;
  final String? bodyString;
  final T? body;

  WebResponse(
    this.statusCode, [
    this.bodyString,
    T Function(Map<String, dynamic> json)? fromJson,
    String? message,
  ])  : statusType = _resolveStatusType(statusCode),
        body = _convertBody(bodyString, fromJson),
        super(
          _resolveStatusType(statusCode) == WebResponseStatusType.success,
          _convertBody(bodyString, fromJson),
          message,
        );

  static T? _convertBody<T>(
    String? bodyString,
    T Function(Map<String, dynamic> json)? fromJson,
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
  static WebResponseStatusType _resolveStatusType(int code) {
    if (code >= 100 && code < 200) {
      return WebResponseStatusType.informational;
    }
    if (code >= 200 && code < 300) {
      return WebResponseStatusType.success;
    }
    if (code >= 300 && code < 400) {
      return WebResponseStatusType.redirection;
    }
    if (code >= 400 && code < 500) {
      return WebResponseStatusType.clientError;
    }
    if (code >= 500 && code < 600) {
      return WebResponseStatusType.serverError;
    }
    return WebResponseStatusType.unknown;
  }
}
