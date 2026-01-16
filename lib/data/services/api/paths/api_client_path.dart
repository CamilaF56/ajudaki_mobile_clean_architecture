import '../../../../utils/web/web_response.dart';
import '../api_client_operations.dart';

class ApiClientPath<T> {
  ApiClientPath(
    this.resource,
    this.fromJson);

  final String resource;
  final T Function(Map<String, dynamic> json) fromJson;

  Future<WebResponse<Map<String, T>>> getAll({
    Map<String, String>? queryParameters,
  }) async {
    return await ApiClientOperations.get<Map<String, T>>(
      resource,
      (json) {
      final map = json as Map<String, dynamic>;
      return map.map<String, T>(
        (key, value) => MapEntry(
          key,
          fromJson(value as Map<String, dynamic>),
        ),
      );
    },
      queryParameters: queryParameters,
    );
  }
}
