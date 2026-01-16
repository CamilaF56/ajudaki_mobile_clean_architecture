
import 'package:ajudaki_mobile_clean_architecture/data/services/api/paths/api_client_path.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/web/web_response.dart';

class FakeApiClientPath<T> extends ApiClientPath<T> {
    FakeApiClientPath(
    super.resource,
    super.fromJson,
  );

  Future<WebResponse<Map<String, T>>> fakeGetAll({
    required  String jsonString,
    Map<String, String>? queryParameters,
  }) async {
    return WebResponse(
      200,
      bodyString: jsonString,
      fromJson: (json) => json.map(
      (key, value) => MapEntry(
        key,
        fromJson(value as Map<String, T>),
      )
    ));
  }
}
