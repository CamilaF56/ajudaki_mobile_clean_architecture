import '../../domain/work_category.dart';
import '../../utils/result.dart';
import '../services/api/paths/api_client_work_categories_path.dart';
import 'repository.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository implements Repository<WorkCategory> {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkCategoryRepository(this._apiPath);

  final ApiClientWorkCategoriesPath _apiPath;
  List<WorkCategory>? _cache;

  @override
  Future<Result<List<WorkCategory>>> getAll() async {
    if (_cache != null) {
      return Result(true, _cache);
    }

    final webResponse = await _apiPath.getAll();

    return Result<List<WorkCategory>>(
      webResponse.isSuccess,
      webResponse.value?.values.toList(),
    );
  }
}
