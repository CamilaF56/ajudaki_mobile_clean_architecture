import 'api_client_config.dart';
import 'paths/api_client_work_categories_path.dart';
import 'paths/api_client_work_listings_path.dart';

class ApiClient {
  ApiClient(this.config)
  {
    workCategories = ApiClientWorkCategoriesPath(config);
    workListings = ApiClientWorkListingsPath(config);
  }

  final ApiClientConfig config;
  late ApiClientWorkCategoriesPath workCategories;
  late ApiClientWorkListingsPath workListings;
}
