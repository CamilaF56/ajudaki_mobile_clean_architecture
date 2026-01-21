import '../../../utils/result.dart';
import '../models/work_listing.dart';
import 'repository.dart';

/// Repositório responsável por obter os anúncios de trabalho.
abstract class WorkListingRepository implements Repository<WorkListing> {
  @override
  Future<Result<List<WorkListing>>> getAll();
  Future<Result<List<WorkListing>>> getByCategory(final int categoryId);
  Future<Result<List<WorkListing>>> getByTerms(final String terms);
}
