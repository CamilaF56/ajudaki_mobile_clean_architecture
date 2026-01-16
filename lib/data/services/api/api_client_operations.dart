import 'package:http/http.dart' as http;
import 'api_client.dart';
import '../../../utils/web/web_response.dart';

class ApiClientOperations {
  static Future<WebResponse<T>> get<T>(
    String path,
    T Function(dynamic json) fromJson, {
    Map<String, String?>? queryParameters
  }) async {
    final uri = Uri.http(
      '${ApiClient.host}:${ApiClient.port}',
      '${ApiClient.basePath}/$path',
      queryParameters
    );

    try {
      final response = await http.get(uri);

      return WebResponse<T>(
        response.statusCode,
        bodyString: response.body,
        fromJson: fromJson
      );
    } catch (e) {
      return WebResponse<T>(
        -1,
        bodyString: e.toString()
      );
    }
  }
}
