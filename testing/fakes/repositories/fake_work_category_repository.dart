import 'package:ajudaki_mobile_clean_architecture/data/repositories/work_category_repository.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';

class FakeWorkCategoryRepository extends WorkCategoryRepository {
  FakeWorkCategoryRepository(_apiPath) : super(_apiPath);

  Response<List<WorkCategory>>? response;

  @override
  Future<Response<List<WorkCategory>>> getAll() async {
    return response ?? Response(true, []);
  }
}
