import 'package:ajudaki_mobile_clean_architecture/data/services/api/paths/api_client_work_listings_path.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/web/web_response.dart';

class FakeApiClientWorkListingsPath extends ApiClientWorkListingsPath {
  FakeApiClientWorkListingsPath() : super();

  @override
  Future<WebResponse<Map<String, WorkListing>>> getAll({
    Map<String, String>? queryParameters,
  }) async {
    String jsonString = '''
    {
      "1": {
        "id": 1,
        "title": "Trocar tomada",
        "description": "",
        "estimatedPrice": 50
      },
      "2": {
        "id": 2,
        "title": "Instalar lâmpada",
        "description": "",
        "estimatedPrice": 40
      }
    }
    ''';

    return WebResponse(
      200,
      bodyString: jsonString,
      fromJson: (json) => json.map(
      (key, value) => MapEntry(
        key,
        fromJson(value as Map<String, dynamic>),
      )
    ));
  }
}
