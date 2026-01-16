import 'package:ajudaki_mobile_clean_architecture/data/services/api/api_client.dart';
import 'package:ajudaki_mobile_clean_architecture/data/services/api/paths/api_client_work_categories_path.dart';
import 'package:ajudaki_mobile_clean_architecture/data/services/api/paths/api_client_work_listings_path.dart';

class FakeApiClient extends ApiClient{
  @override
  static final ApiClientWorkCategoriesPath workCategories = FakeApiClientWorkCategoriesPath();
  @override
  static final ApiClientWorkListingsPath workListings = FakeApiClientWorkListingsPath();
}