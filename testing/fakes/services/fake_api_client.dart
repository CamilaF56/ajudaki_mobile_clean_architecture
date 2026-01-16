import 'package:ajudaki_mobile_clean_architecture/data/services/api/api_client.dart';
import 'fake_api_client_work_categories_path.dart';
import 'fake_api_client_work_listings_path.dart';

class FakeApiClient extends ApiClient {
  static final FakeApiClientWorkCategoriesPath workCategories =
      FakeApiClientWorkCategoriesPath();

  static final FakeApiClientWorkListingsPath workListings =
      FakeApiClientWorkListingsPath();
}
