import '../../../utils/result.dart';
import '../../models/work_category.dart';
import '../../services/api_client.dart';
import '../work_category_repository.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRemoteRepository implements WorkCategoryRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkCategoryRemoteRepository(this._apiClient);

  final ApiClient _apiClient;
  List<WorkCategory>? _cache;

  /// Retorna todas as categorias de trabalho.
  ///
  /// Caso exista cache, os dados são retornados diretamente.
  /// Caso contrário, a lista é buscada na API.
  @override
  Future<Result<List<WorkCategory>>> getAll() async {
    if (_cache == null) {
      final webResponse = await _apiClient.workCategories.getAll();

      if (webResponse.isSuccess) {
        _cache = webResponse.value?.values.toList();
      }
    }

    return Result(true, _cache);
  }
}
