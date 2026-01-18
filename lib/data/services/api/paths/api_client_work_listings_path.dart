import '../../../../domain/work_listing.dart';
import '../../../../utils/web/web_result.dart';
import '../api_client_operations.dart';
import 'api_client_path.dart';

class ApiClientWorkListingsPath extends ApiClientPath<WorkListing> {
  ApiClientWorkListingsPath(final ApiClientOperations operations)
      : super(
          operations,
          'worklistings',
          WorkListing.fromJson);

  Future<WebResult<Map<String, WorkListing>>> search(
    final Map<String, String?> queryParameters ) async {
    return operations.get<Map<String, WorkListing>>(
      resource,
      (final json) {
        final map = json;
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
