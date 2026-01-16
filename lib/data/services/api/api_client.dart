import './paths/api_client_work_categories_path.dart';
import './paths/api_client_work_listings_path.dart';

/// Cliente responsável pela comunicação HTTP com a API backend.
class ApiClient {
  ApiClient()
  : workCategories = ApiClientWorkCategoriesPath(),
    workListings = ApiClientWorkListingsPath();

  final ApiClientWorkCategoriesPath workCategories;
  final ApiClientWorkListingsPath workListings;

  static const String host = 'localhost';
  static const String basePath = '/api';
  static const int port = 5299;
}
