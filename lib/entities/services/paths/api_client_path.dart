import '../../../utils/web/web_result.dart';
import '../api_client_config.dart';
import '../api_client_operations.dart';

abstract class ApiClientPath<T> {
  ApiClientPath(
    this.apiClientConfig,
    this.resource,
    this.fromJson);

  final ApiClientConfig apiClientConfig;
  final String resource;
  final T Function(Map<String, dynamic> json) fromJson;

  Future<WebResult<Map<String, T>>> getAll({
    final Map<String, String>? queryParameters,
  }) async {
    return ApiClientOperations.get<Map<String, T>>(
      apiClientConfig,
      resource,
      (final json) {
        final map = json;
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
