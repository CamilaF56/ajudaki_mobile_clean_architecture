import '../../../utils/web/web_result.dart';
import '../../models/work_listing.dart';
import '../api_client_operations.dart';
import 'api_client_path.dart';

class ApiClientWorkListingsPath extends ApiClientPath<WorkListing> {
  ApiClientWorkListingsPath(final apiClientConfig)
    : super(
    apiClientConfig,
    'worklistings',
    WorkListing.fromJson);

  static const String workCategoryId = 'workCategoryId';
  static const String terms = 'terms';

  Future<WebResult<Map<String, WorkListing>>> search({
    final String? workCategoryId,
    final String? terms}) async {
    final queryParameters = <String, String?>{};
    queryParameters['workCategoryId'] = workCategoryId;
    queryParameters['terms'] = terms;

    return ApiClientOperations.get<Map<String, WorkListing>>(
      apiClientConfig,
      '$resource/search',
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
