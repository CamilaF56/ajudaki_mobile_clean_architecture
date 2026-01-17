import '../../domain/work_category.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository {
  WorkCategoryRepository();

  List<WorkCategory>? cache;

  Future<Response<List<WorkCategory>>> getAll() async {
  if (cache != null) {
      return Response(true, cache);
    }

  final webResponse = await ApiClient.workCategories.getAll();

  return Response<List<WorkCategory>>(
    webResponse.isSuccess,
    webResponse.body?.values.toList(),
  );
  }
}
