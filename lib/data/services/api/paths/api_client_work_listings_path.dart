import '../api_client_operations.dart';
import '../../../../domain/work_listing.dart';
import 'api_client_path.dart';

class ApiClientWorkListingsPath extends ApiClientPath<WorkListing> {
  ApiClientWorkListingsPath()
  : super('worklistings', WorkListing.fromJson);

  Future<Map<String, WorkListing>?> search({
    Map<String, String>? queryParameters,
  }) async {
    final response = await ApiClientOperations.get<Map<String, WorkListing>>(
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
      queryParameters: queryParameters,
    );

    if (!response.isSuccess) return null;
    return response.body;
  }
}
