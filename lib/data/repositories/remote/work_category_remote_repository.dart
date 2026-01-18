import '../../../domain/work_category.dart';
import '../../../utils/result.dart';
import '../../services/api/paths/api_client_work_categories_path.dart';
import '../work_category_repository.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRemoteRepository implements WorkCategoryRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkCategoryRemoteRepository(final apiClientConfig)
  : _apiPath = ApiClientWorkCategoriesPath(apiClientConfig);

  final ApiClientWorkCategoriesPath _apiPath;
  List<WorkCategory>? _cache;

  /// Retorna todas as categorias de trabalho.
  ///
  /// Caso exista cache, os dados são retornados diretamente.
  /// Caso contrário, a lista é buscada na API.
  @override
  Future<Result<List<WorkCategory>>> getAll() async {
    if (_cache == null) {
      final webResponse = await _apiPath.getAll();

      if (webResponse.isSuccess) {
        _cache = webResponse.value?.values.toList();
      }
    }

    return Result(true, _cache);
  }
}
