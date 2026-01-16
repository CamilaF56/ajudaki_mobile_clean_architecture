import '../../domain/work_category.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository {
  Future<Response<List<WorkCategory>>> getAll() async {
    final webResponse = await ApiClient.workCategories.getAll();

    if (!webResponse.isSuccess) {
      return Response.error(Exception(webResponse.statusCode.toString()));
    }

    return Response.success(webResponse.body!.values.toList());
  }
}
