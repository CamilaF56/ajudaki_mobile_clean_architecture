import 'package:ajudaki_mobile_clean_architecture/utils/web/web_response.dart';

import '../api_client_operations.dart';
import '../../../../domain/work_listing.dart';
import 'api_client_path.dart';

class ApiClientWorkListingsPath extends ApiClientPath<WorkListing> {
  ApiClientWorkListingsPath()
  : super('worklistings', WorkListing.fromJson);

  Future<WebResponse<Map<String, WorkListing>>> search(
    Map<String, String?> queryParameters
  ) async {
    return await ApiClientOperations.get<Map<String, WorkListing>>(
      resource,
      (json) {
        final map = json as Map<String, dynamic>;
        return map.map(
          (key, value) => MapEntry(
            key,
            fromJson(value as Map<String, dynamic>),
          ),
        );
      },
      queryParameters: queryParameters
    );
  }
}
