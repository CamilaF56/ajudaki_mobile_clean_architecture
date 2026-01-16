import '../api_client_operations.dart';

class ApiClientPath<T> {
  ApiClientPath(
    this.resource,
    this.fromJson);

  final String resource;
  final T Function(Map<String, dynamic> json) fromJson;

  Future<T?> get({
  Map<String, String>? queryParameters,
  }) async {
    final response = await ApiClientOperations.get<T>(
      resource,
      (json) => fromJson(json as Map<String, dynamic>),
      queryParameters: queryParameters,
    );

    if (!response.isSuccess) return null;
    return response.body;
  }

  Future<Map<String, T>?> getAll({
    Map<String, String>? queryParameters,
  }) async {
    final response = await ApiClientOperations.get<Map<String, T>>(
      resource,
      (json) {
        final map = json as Map<String, T>;
        return map.map(
          (key, value) => MapEntry(
            key,
            fromJson(value as Map<String, T>),
          ),
        );
      },
      queryParameters: queryParameters,
    );

    if (!response.isSuccess) return null;
    return response.body;
  }
}
