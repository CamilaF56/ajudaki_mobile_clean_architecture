import '../../domain/work_category.dart';
import '../../utils/response.dart';
import '../services/api/paths/api_client_work_categories_path.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkCategoryRepository(this._apiPath);

  final ApiClientWorkCategoriesPath _apiPath;
  List<WorkCategory>? _cache;

  Future<Response<List<WorkCategory>>> getAll() async {
    if (_cache != null) {
      return Response(true, _cache);
    }

    final webResponse = await _apiPath.getAll();

    return Response<List<WorkCategory>>(
      webResponse.isSuccess,
      webResponse.body?.values.toList(),
    );
  }
}
