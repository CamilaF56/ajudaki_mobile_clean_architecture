import '../../domain/work_category.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkCategoryRepository(this._apiClient);

  /// Cliente responsável pela comunicação com a API.
  final ApiClient _apiClient;

  /// Cache em memória das categorias já carregadas.
  ///
  /// Evita chamadas repetidas à API.
  List<WorkCategory>? cache;

  /// Retorna todas as categorias de trabalho.
  ///
  /// Caso exista cache, os dados são retornados diretamente.
  /// Caso contrário, a lista é buscada na API.
  Future<Response<List<WorkCategory>>> getAll() async {
    if (cache != null) {
      return Future.value(Response.success(cache!));
    }

    final result = await _apiClient.getWorkCategories();

    return switch (result) {
      Success(value: final map) => () {
        final list = map.values.toList();
        cache = list;
        return Response.success(list);
      }(),
      Error(error: final error) => Response.error(error),
    };
  }
}
