import 'work_category_repository.dart';
import 'work_listing_repository.dart';

class Repositories {
  Repositories(
    this.workCategories,
    this.workListings);

  late WorkCategoryRepository workCategories;
  late WorkListingRepository workListings;
}
