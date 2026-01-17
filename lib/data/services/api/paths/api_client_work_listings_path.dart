import '../../../../domain/work_listing.dart';
import '../../../../utils/web/web_response.dart';
import '../api_client_operations.dart';
import 'api_client_path.dart';

class ApiClientWorkListingsPath extends ApiClientPath<WorkListing> {
  ApiClientWorkListingsPath(final ApiClientOperations operations)
      : super(
          operations,
          'worklistings',
          WorkListing.fromJson);

  Future<WebResponse<Map<String, WorkListing>>> search(
    final Map<String, String?> queryParameters ) async {
    return operations.get<Map<String, WorkListing>>(
      resource,
      (final json) {
        final map = json as Map<String, dynamic>;
        return map.map(
          (final key, final value) => MapEntry(
            key,
            fromJson(value as Map<String, dynamic>),
          ),
        );
      },
      queryParameters: queryParameters
    );
  }
}
