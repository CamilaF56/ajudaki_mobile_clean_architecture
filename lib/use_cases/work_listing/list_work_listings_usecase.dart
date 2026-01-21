import '../../entities/models/work_listing.dart';
import '../../entities/repositories/work_listing_repository.dart';
import '../../utils/result.dart';

class ListWorkListingsUsecase {
  ListWorkListingsUsecase(this._workListingsRepository);

  final WorkListingRepository _workListingsRepository;

  Future<Result<List<WorkListing>>> execute() async {
    try {
      final workListings = await _workListingsRepository.getAll();
      return Result(true, workListings.value);
    } on Exception catch (e) {
      return Result(false);
    }
  }
}
