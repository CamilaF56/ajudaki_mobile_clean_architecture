import '../json_converter.dart';
import '../result.dart';
import 'web_result_status.dart';
import 'web_result_status_type.dart';

/// Classe que representa uma resposta de uma API web.
///
/// Contém o código HTTP bruto, o JSON original como string
/// e o corpo convertido para o tipo [T].
class WebResult<T> extends Result<T> {
  WebResult.withJson(
    final int numCode, [
    final String? body,
    final T Function(Map<String, dynamic> json)? jsonConverter
  ]) : super(
        WebResultStatus(numCode).type == WebResultStatusType.success,
        fromJson(body, jsonConverter)
      );

  WebResult.withValue(
    final int numCode, [
    final T? value
  ]) : super(
        WebResultStatus(numCode).type == WebResultStatusType.success,
        value
      );
}
