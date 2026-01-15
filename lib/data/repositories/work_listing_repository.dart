import '../../models/work_listing.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter os anúncios de trabalho.
class WorkListingRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkListingRepository(this._apiClient);

  /// Cliente responsável pela comunicação com a API.
  final ApiClient _apiClient;

  /// Cache em memória dos anúncios já carregados.
  ///
  /// Evita chamadas repetidas à API.
  List<WorkListing>? cache;

  /// Retorna todos os anúncios de trabalho.
  ///
  /// Caso exista cache, os dados são retornados diretamente.
  /// Caso contrário, a lista é buscada na API.
  Future<Response<List<WorkListing>>> getAll() async {
    if (cache != null) {
      return Future.value(Response.success(cache!));
    }

    final result = await _apiClient.getWorkListings();

    return switch (result) {
      Success(value: final map) => () {
        final list = map.values.toList();
        cache = list;
        return Response.success(list);
      }(),
      Error(error: final error) => Response.error(error),
    };
  }

  /// Retorna os anúncios filtrados por categoria.
  ///
  /// Caso exista cache, o filtro é aplicado localmente.
  /// Caso contrário, a busca é realizada via API.
  Future<Response<List<WorkListing>>> getByCategory(
    final int categoryId,
  ) async {
    if (cache != null) {
      final filtered = cache!
          .where(
            (final workListing) =>
                workListing.workType?.workCategory?.id == categoryId,
          )
          .toList();

      return Future.value(Response.success(filtered));
    }

    final result = await _apiClient.searchWorkListings(null, categoryId);

    return switch (result) {
      Success(value: final map) => Response.success(map.values.toList()),
      Error(error: final error) => Response.error(error),
    };
  }

  /// Retorna os anúncios filtrados pelo termo de busca.
  ///
  /// Caso exista cache, o filtro é aplicado localmente.
  /// Caso contrário, a busca é realizada via API.
  Future<Response<List<WorkListing>>> getByTerm(final String terms) async {
    if (cache != null) {
      final filtered = cache!
          .where(
            (final workListing) =>
                workListing.title.toLowerCase().contains(terms.toLowerCase()),
          )
          .toList();

      return Future.value(Response.success(filtered));
    }

    final result = await _apiClient.searchWorkListings(terms, null);

    return switch (result) {
      Success(value: final map) => Response.success(map.values.toList()),
      Error(error: final error) => Response.error(error),
    };
  }
}
