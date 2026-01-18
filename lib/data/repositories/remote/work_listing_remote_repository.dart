import '../../../domain/work_listing.dart';
import '../../../utils/result.dart';
import '../../services/api/paths/api_client_work_listings_path.dart';
import '../work_listing_repository.dart';

/// Repositório responsável por obter os anúncios de trabalho.
class WorkListingRemoteRepository implements WorkListingRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkListingRemoteRepository(final apiClientConfig)
  : _apiPath = ApiClientWorkListingsPath(apiClientConfig);

  final ApiClientWorkListingsPath _apiPath;
  List<WorkListing>? _cache;

  /// Retorna todos os anúncios de trabalho.
  ///
  /// Caso exista cache, os dados são retornados diretamente.
  /// Caso contrário, a lista é buscada na API.
  @override
  Future<Result<List<WorkListing>>> getAll() async {
    if (_cache == null) {
      final webResponse = await _apiPath.getAll();

      if (webResponse.isSuccess) {
        _cache = webResponse.value?.values.toList();
      }
    }

    return Result(true, _cache);
  }

  /// Retorna os anúncios filtrados por categoria.
  ///
  /// Caso exista cache, o filtro é aplicado localmente.
  @override
  Future<Result<List<WorkListing>>> getByCategory(
    final int categoryId) async {
      if (_cache != null) {
      final filtered = _cache!
        .where(
          (final workListing) =>
            workListing.workType?.workCategory?.id == categoryId
        ).toList();

      return Result(true, filtered);
    }

    final webResponse = await _apiPath.search(
      workCategoryId: categoryId.toString());

    return Result<List<WorkListing>>(
      webResponse.isSuccess,
      webResponse.value?.values.toList()
    );
  }

  /// Retorna os anúncios filtrados pelo termo de busca.
  ///
  /// A busca é realizada via API.
  @override
  Future<Result<List<WorkListing>>> getByTerm(final String terms) async {
    final result = await _apiPath.search(
      terms: terms);

    List<WorkListing>? list;
    if (result.isSuccess) {
      list = result.value?.values.toList();
    }

    return Result(true, list);
  }
}
