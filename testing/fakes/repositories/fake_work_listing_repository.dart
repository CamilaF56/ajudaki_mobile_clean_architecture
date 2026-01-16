import 'package:ajudaki_mobile_clean_architecture/data/repositories/work_listing_repository.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';

class FakeWorkListingRepository extends WorkListingRepository {
  FakeWorkListingRepository() : super();

  Response<List<WorkListing>>? response;
  Response<List<WorkListing>>? filterResponse;

  @override
  Future<Response<List<WorkListing>>> getAll() async {
    return response ?? Response(true, []);
  }

  @override
  Future<Response<List<WorkListing>>> getByCategory(int categoryId) async {
    return filterResponse ?? Response(true, []);
  }

  @override
  Future<Response<List<WorkListing>>> getByTerm(String term) async {
    return response ?? Response(true, []);
  }
}