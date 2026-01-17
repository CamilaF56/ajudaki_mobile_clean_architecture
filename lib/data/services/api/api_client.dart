import './paths/api_client_work_categories_path.dart';
import './paths/api_client_work_listings_path.dart';
import 'api_client_operations.dart';

/// Cliente responsável pela comunicação HTTP com a API backend.
class ApiClient {
  ApiClient(final config) {
    operations = ApiClientOperations(config);
    workCategories = ApiClientWorkCategoriesPath(operations);
    workListings = ApiClientWorkListingsPath(operations);
  }

  late final ApiClientOperations operations;
  late final ApiClientWorkCategoriesPath workCategories;
  late final ApiClientWorkListingsPath workListings;
}
