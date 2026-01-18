import './paths/api_client_work_categories_path.dart';
import './paths/api_client_work_listings_path.dart';

/// Cliente responsável pela comunicação HTTP com a API backend.
class ApiClient {
  ApiClient(final config) {
    workCategories = ApiClientWorkCategoriesPath(config);
    workListings = ApiClientWorkListingsPath(config);
  }

  late final ApiClientWorkCategoriesPath workCategories;
  late final ApiClientWorkListingsPath workListings;
}
