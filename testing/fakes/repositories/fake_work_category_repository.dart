import 'package:ajudaki_mobile_clean_architecture/entities/repositories/work_category_repository.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/models/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/result.dart';

class FakeWorkCategoryRepository implements WorkCategoryRepository {
  FakeWorkCategoryRepository();

  Result<List<WorkCategory>>? response;

  @override
  Future<Result<List<WorkCategory>>> getAll() async {
    return response ?? Result(true, []);
  }
}
