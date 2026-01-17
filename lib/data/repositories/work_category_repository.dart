import '../../domain/work_category.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

/// Repositório responsável por obter as categorias de trabalho.
class WorkCategoryRepository {
  /// Cria o repositório com o cliente de API utilizado nas requisições.
  WorkCategoryRepository();

  List<WorkCategory>? _cache;

  Future<Response<List<WorkCategory>>> getAll() async {
  if (_cache != null) {
      return Response(true, _cache);
    }

  final webResponse = await ApiClient.workCategories.getAll();

  return Response<List<WorkCategory>>(
    webResponse.isSuccess,
    webResponse.body?.values.toList(),
  );
  }
}
