import 'package:ajudaki_mobile_clean_architecture/data/repositories/work_category_repository.dart';
import 'package:ajudaki_mobile_clean_architecture/models/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';
import '../services/fake_api_client.dart';

class FakeWorkCategoryRepository extends WorkCategoryRepository {
  FakeWorkCategoryRepository() : super(FakeApiClient());

  /// Resposta configurável para os testes
  Response<List<WorkCategory>>? response;

  @override
  Future<Response<List<WorkCategory>>> getAll() async {
    return response ?? Response.success([]);
  }
}