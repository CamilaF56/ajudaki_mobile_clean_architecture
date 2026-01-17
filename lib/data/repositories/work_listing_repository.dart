import '../../domain/work_listing.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter os anúncios de trabalho.
class WorkListingRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkListingRepository(this._apiClient);

  final ApiClient _apiClient;
  List<WorkListing>? _cache;

  /// Retorna todos os anúncios de trabalho.
  ///
  /// Caso exista cache, os dados são retornados diretamente.
  /// Caso contrário, a lista é buscada na API.
  Future<Response<List<WorkListing>>> getAll() async {
    if (_cache == null) {
      final webResponse = await _apiClient.workListings.getAll();

      if (webResponse.isSuccess) {
        _cache = webResponse.body?.values.toList();
      }
    }
    
    return Response(true, _cache);
  }

  /// Retorna os anúncios filtrados por categoria.
  ///
  /// Caso exista cache, o filtro é aplicado localmente.
  Future<Response<List<WorkListing>>> getByCategory(
    final int categoryId) async {
      if (_cache != null) {
      final filtered = _cache!
          .where(
            (final workListing) =>
                workListing.workType?.workCategory?.id == categoryId,
          )
          .toList();

      return Response(true, filtered);
    }

    final queryParameters = <String, String?>{};
    queryParameters['workCategoryId'] = categoryId.toString();
    final webResponse = await _apiClient.workListings.search(queryParameters);

    return Response<List<WorkListing>>(
      webResponse.isSuccess,
      webResponse.body?.values.toList()
    );
  }

  /// Retorna os anúncios filtrados pelo termo de busca.
  ///
  /// A busca é realizada via API.
  Future<Response<List<WorkListing>>> getByTerm(final String terms) async {
    final queryParameters = <String, String?>{};
    queryParameters['terms'] = terms;
    final result = await _apiClient.workListings.search(queryParameters);

    List<WorkListing>? list;
    if (result.isSuccess) {
      list = result.body?.values.toList();
    }

    return Response(true, list);
  }
}
