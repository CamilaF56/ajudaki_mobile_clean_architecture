import '../../../models/professional.dart';
import '../../../models/work_category.dart';
import '../../../models/work_listing.dart';
import '../../../models/work_type.dart';
import '../../../utils/response.dart';
import 'http_get_helper.dart';

/// Cliente responsável pela comunicação HTTP com a API backend.
class ApiClient {
  /// Cria uma instância do cliente de API.
  ApiClient();

  /// Endereço do servidor da API.
  final String _host = 'localhost';

  /// Porta utilizada para acesso à API.
  final int _port = 5299;

  /// Helper responsável por realizar requisições HTTP GET.
  final HttpGetHelper _helper = HttpGetHelper();

  /// Retorna todos os anúncios de trabalho.
  Future<Response<Map<int, WorkListing>>> getWorkListings() =>
      _helper.getMap(_host, _port, '/api/worklistings', WorkListing.fromJson);

  /// Retorna um anúncio de trabalho pelo identificador.
  Future<Response<WorkListing>> getWorkListing(final int id) =>
      _helper.get(_host, _port, '/api/worklistings/$id', WorkListing.fromJson);

  /// Realiza a busca de anúncios de trabalho por termo e/ou categoria.
  ///
  /// Ambos os parâmetros são opcionais e utilizados conforme informados.
  Future<Response<Map<int, WorkListing>>> searchWorkListings(
    final String? terms,
    final int? workCategoryId,
  ) {
    final queryParameters = <String, String>{};

    if (terms != null) {
      queryParameters['terms'] = terms;
    }

    if (workCategoryId != null) {
      queryParameters['workCategoryId'] = workCategoryId.toString();
    }

    return _helper.getMap(
      _host,
      _port,
      '/api/worklistings/search',
      WorkListing.fromJson,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  /// Retorna todas as categorias de trabalho.
  Future<Response<Map<int, WorkCategory>>> getWorkCategories() => _helper
      .getMap(_host, _port, '/api/workcategories', WorkCategory.fromJson);

  /// Retorna uma categoria de trabalho pelo identificador.
  Future<Response<WorkCategory>> getWorkCategory(final int id) => _helper.get(
    _host,
    _port,
    '/api/workcategories/$id',
    WorkCategory.fromJson,
  );

  /// Retorna todos os tipos de trabalho.
  Future<Response<Map<int, WorkType>>> getWorkTypes() =>
      _helper.getMap(_host, _port, '/api/worktypes', WorkType.fromJson);

  /// Retorna um tipo de trabalho pelo identificador.
  Future<Response<WorkType>> getWorkType(final int id) =>
      _helper.get(_host, _port, '/api/worktypes/$id', WorkType.fromJson);

  /// Retorna todos os profissionais cadastrados.
  Future<Response<Map<int, Professional>>> getProfessionals() =>
      _helper.getMap(_host, _port, '/api/professionals', Professional.fromJson);

  /// Retorna um profissional pelo identificador.
  Future<Response<Professional>> getProfessional(final int id) => _helper.get(
    _host,
    _port,
    '/api/professionals/$id',
    Professional.fromJson,
  );
}
