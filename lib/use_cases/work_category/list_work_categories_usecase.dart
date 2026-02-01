import '../../entities/models/work_category.dart';
import '../../entities/repositories/work_category_repository.dart';
import '../../utils/result.dart';

class ListWorkCategoriesUsecase {
  ListWorkCategoriesUsecase(this._workCategoryRepository);

  final WorkCategoryRepository _workCategoryRepository;

  Future<Result<List<WorkCategory>>> execute() async {
    try {
      final workCategories = await _workCategoryRepository.getAll();
      return workCategories;
    } on Exception catch (_) {
      return Result(false);
    }
  }
}
