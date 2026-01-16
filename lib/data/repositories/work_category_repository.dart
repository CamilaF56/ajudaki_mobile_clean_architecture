import '../../domain/work_category.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository {
  WorkCategoryRepository();

  Future<Response<List<WorkCategory>>> getAll() async {
  final webResponse = await ApiClient.workCategories.getAll();

  // Safely map dynamic values into WorkCategory
  final categories = webResponse.body?.values
      .map((e) => e) // e is already WorkCategory due to your fromJson
      .toList();

  return Response<List<WorkCategory>>(
    webResponse.isSuccess,
    categories,
  );
  }
}
