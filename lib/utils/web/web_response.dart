import 'dart:convert';
import 'package:ajudaki_mobile_clean_architecture/utils/web/web_response_status_type.dart';

/// Classe base selada que representa uma resposta de uma API web.
///
/// Contém o código HTTP bruto, o JSON original como string
/// e o corpo convertido para o tipo [T].
sealed class WebResponse<T> {
  /// Código HTTP retornado pela API
  final int statusCode;

  /// Tipo categorizado da resposta HTTP
  final WebResponseStatusType statusType;

  /// Corpo da resposta em formato JSON (string bruta)
  final String? bodyString;

  /// Corpo da resposta convertido para [T]
  final T? body;

  /// Cria uma instância de [WebResponse].
  ///
  /// [bodyString] deve ser uma string JSON.
  /// [fromJson] é responsável por converter o JSON em [T].
  WebResponse(
    this.statusCode, {
    this.bodyString,
    T Function(Map<String, dynamic> json)? fromJson,
  })  : statusType = _resolveStatusType(statusCode),
        body = _convertBody(bodyString, fromJson);

  /// Indica se a resposta foi bem-sucedida (qualquer 2xx).
  bool get isSuccess => statusType == WebResponseStatusType.success;

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
