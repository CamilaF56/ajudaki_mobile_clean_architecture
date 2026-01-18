import '../json_converter.dart';
import '../result.dart';
import 'web_result_status.dart';
import 'web_result_status_type.dart';

/// Classe que representa uma resposta de uma API web.
///
/// Contém o código HTTP bruto, o JSON original como string
/// e o corpo convertido para o tipo [T].
class WebResult<T> extends Result<T> {
  WebResult(
    final int numCode, [
    this.body,
    final T Function(Map<String, dynamic> json)? jsonConverter
  ]) : super(
        WebResultStatus(numCode).type != WebResultStatusType.success,
        fromJson(body, jsonConverter)
      );

  final String? body;
}
