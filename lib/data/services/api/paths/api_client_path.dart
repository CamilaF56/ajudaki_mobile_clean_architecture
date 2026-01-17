import '../../../../utils/web/web_response.dart';
import '../api_client_operations.dart';

class ApiClientPath<T> {
  ApiClientPath(this.operations, this.resource, this.fromJson);

  final ApiClientOperations operations;
  final String resource;
  final T Function(Map<String, dynamic> json) fromJson;

  Future<WebResponse<Map<String, T>>> getAll({
    final Map<String, String>? queryParameters,
  }) async {
    return operations.get<Map<String, T>>(
      resource,
      (final json) {
      final map = json as Map<String, dynamic>;
      return map.map<String, T>(
        (final key, final value) => MapEntry(
          key,
          fromJson(value as Map<String, dynamic>),
        ),
      );
    },
      queryParameters: queryParameters,
    );
  }
}
