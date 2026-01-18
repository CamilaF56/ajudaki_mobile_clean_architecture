import 'package:ajudaki_mobile_clean_architecture/data/services/api/api_client_operations.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import './paths/api_client_work_categories_path.dart';
import './paths/api_client_work_listings_path.dart';

/// Cliente responsável pela comunicação HTTP com a API backend.
class ApiClient {
  ApiClient(final config) {
    workCategories = ApiClientWorkCategoriesPath(ApiClientOperations<WorkCategory>(config));
    workListings = ApiClientWorkListingsPath(ApiClientOperations<WorkListing>(config));
  }

  late final ApiClientWorkCategoriesPath workCategories;
  late final ApiClientWorkListingsPath workListings;
}
