import 'package:http/http.dart' as http;
import '../../utils/web/web_result.dart';
import 'api_client_config.dart';

class ApiClientOperations {
  ApiClientOperations._();

  static Future<WebResult<T>> get<T>(
    final ApiClientConfig config,
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    final Map<String, String?>? queryParameters
  }) async {
    final uri = Uri.http(
      config.authority,
      config.createUnencodedPath(path),
      queryParameters
    );

    try {
      final response = await http.get(uri);

      return WebResult<T>.withJson(
        response.statusCode,
        response.body,
        fromJson
      );
    } on Exception catch (e) {
      return WebResult<T>.withJson(
        -1,
        e.toString()
      );
    }
  }
}
