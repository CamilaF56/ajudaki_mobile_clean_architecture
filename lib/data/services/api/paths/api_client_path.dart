import '../../../../utils/web/web_response.dart';
import '../api_client_operations.dart';

class ApiClientPath<T> {
  ApiClientPath(
    this.resource,
    this.fromJson);

  final String resource;
  final T Function(Map<String, dynamic> json) fromJson;

  Future<WebResponse<T>> get({
  Map<String, String>? queryParameters,
  }) async {
    return await ApiClientOperations.get<T>(
      resource,
      (json) => fromJson(json as Map<String, dynamic>),
      queryParameters: queryParameters,
    );
  }

  Future<WebResponse<Map<String, T>>> getAll({
    Map<String, String>? queryParameters,
  }) async {
    return await ApiClientOperations.get<Map<String, T>>(
      resource,
      (json) => json.map(
      (key, value) => MapEntry(
        key,
        fromJson(value as Map<String, dynamic>),
      )),
      queryParameters: queryParameters,
    );
  }
}
