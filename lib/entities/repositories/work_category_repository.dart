import '../../../utils/result.dart';
import '../models/work_category.dart';
import 'repository.dart';

/// Repositório responsável por obter as categorias de trabalho.
abstract class WorkCategoryRepository implements Repository<WorkCategory> {
  @override
  Future<Result<List<WorkCategory>>> getAll();
}
