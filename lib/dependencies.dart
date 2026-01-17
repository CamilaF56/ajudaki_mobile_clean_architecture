import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../ui/work_listing/view_models/work_listing_view_model.dart';
import 'data/repositories/work_category_repository.dart';
import 'data/repositories/work_listing_repository.dart';
import 'data/services/api/api_client.dart';
import 'data/services/api/api_client_config.dart';

/// Conjunto de providers responsáveis por configurar o acesso remoto.
///
/// Centraliza a criação e injeção de dependências relacionadas
/// à comunicação com a API e aos repositórios.
List<SingleChildWidget> get providersRemote {
  const apiClientConfig = ApiClientConfig(
    'localhost',
    5299,
    'api');

  final apiClient = ApiClient(apiClientConfig);

  return [
    Provider.value(value: apiClient),

    Provider(create: (_) => WorkCategoryRepository(apiClient.workCategories)),
    Provider(create: (_) => WorkListingRepository(apiClient.workListings)),

    ChangeNotifierProvider(
      create: (final context)
      => WorkListingViewModel(
        context.read(),
        context.read()
      ),
    ),
  ];
}
