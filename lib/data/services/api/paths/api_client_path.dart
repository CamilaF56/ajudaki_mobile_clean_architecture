import '../../../../utils/web/web_result.dart';
import '../api_client_operations.dart';

abstract class ApiClientPath<T> {
  ApiClientPath(this.operations, this.resource, this.fromJson);

  final String resource;
  final T Function(Map<String, dynamic> json) fromJson;
  final ApiClientOperations<T> operations;

  Future<WebResult<Map<String, T>>> getAll({
    final Map<String, String>? queryParameters,
  }) async {
    return operations.get<Map<String, T>>(
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
