import '../../entities/models/work_listing.dart';
import '../../entities/repositories/work_listing_repository.dart';
import '../../utils/result.dart';

class SearchWorkListingsByCategoryUsecase {
  SearchWorkListingsByCategoryUsecase(this._workListingsRepository);

  final WorkListingRepository _workListingsRepository;

  Future<Result<List<WorkListing>>> execute(final int categoryId) async {
    try {
      final workListings =
      await _workListingsRepository.getByCategory(categoryId);
      return workListings;
    } on Exception catch (_) {
      return Result(false);
    }
  }
}
