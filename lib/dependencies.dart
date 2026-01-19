import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'data/repositories/remote/work_category_remote_repository.dart';
import 'data/repositories/remote/work_listing_remote_repository.dart';
import 'data/repositories/repositories.dart';
import 'data/services/api/api_client.dart';
import 'data/services/api/api_client_config.dart';
import 'ui/work_listing/work_listing_view_controller.dart';

/// Conjunto de providers responsáveis por configurar o acesso remoto.
///
/// Centraliza a criação e injeção de dependências relacionadas
/// à comunicação com a API e aos repositórios.
List<SingleChildWidget> get providersRemote {
  const apiClientConfig = ApiClientConfig(
    'localhost',
    5299,
    'api'
  );

  final apiClient = ApiClient(apiClientConfig);

  final remoteRepositories = Repositories(
    WorkCategoryRemoteRepository(apiClient),
    WorkListingRemoteRepository(apiClient));

  return [
    Provider.value(value: apiClientConfig),
    Provider.value(value: remoteRepositories),

    ChangeNotifierProvider(
      create: (final context) => WorkListingViewModel(remoteRepositories)
    ),
  ];
}
