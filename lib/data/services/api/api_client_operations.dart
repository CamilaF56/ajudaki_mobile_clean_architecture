import 'package:http/http.dart' as http;
import '../../../utils/web/web_response.dart';
import 'api_client_config.dart';

class ApiClientOperations {
  ApiClientOperations(this._config);

  final ApiClientConfig _config;

  Future<WebResponse<T>> get<T>(
    final String path,
    final T Function(dynamic json) fromJson, {
    final Map<String, String?>? queryParameters
  }) async {
    final uri = Uri.http(
      _config.authority,
      _config.createUnencodedPath(path),
      queryParameters
    );

    try {
      final response = await http.get(uri);

      return WebResponse<T>(
        response.statusCode,
        response.body,
        fromJson
      );
    } on Exception catch (e) {
      return WebResponse<T>(
        -1,
        e.toString()
      );
    }
  }
}
