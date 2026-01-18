import 'package:ajudaki_mobile_clean_architecture/data/repositories/work_listing_repository.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/result.dart';

class FakeWorkListingRepository implements WorkListingRepository {
  FakeWorkListingRepository();

  Result<List<WorkListing>>? response;

  @override
  Future<Result<List<WorkListing>>> getAll() async {
    return response ?? Result(true, []);
  }

  @override
  Future<Result<List<WorkListing>>> getByCategory(int categoryId) async {
    return response ?? Result(true, []);
  }

  @override
  Future<Result<List<WorkListing>>> getByTerm(String term) async {
    return response ?? Result(true, []);
  }
}
