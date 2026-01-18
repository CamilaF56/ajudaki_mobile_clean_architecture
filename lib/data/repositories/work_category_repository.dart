import '../../../domain/work_category.dart';
import '../../../utils/result.dart';
import 'repository.dart';

/// Repositório responsável por obter as categorias de trabalho.
abstract class WorkCategoryRepository implements Repository<WorkCategory> {
  Future<Result<List<WorkCategory>>> getAll();
}
