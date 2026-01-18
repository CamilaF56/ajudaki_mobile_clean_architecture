import '../../../domain/work_listing.dart';
import '../../../utils/result.dart';
import 'repository.dart';

/// Repositório responsável por obter os anúncios de trabalho.
abstract class WorkListingRepository implements Repository<WorkListing> {
  @override
  Future<Result<List<WorkListing>>> getAll();
  Future<Result<List<WorkListing>>> getByCategory(final int categoryId);
  Future<Result<List<WorkListing>>> getByTerm(final String terms);
}
