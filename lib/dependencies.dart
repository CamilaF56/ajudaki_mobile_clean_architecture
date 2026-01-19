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
List<SingleChildWidget> get providers {
  const apiClientConfig = ApiClientConfig(
    'localhost',
    5299,
    'api'
  );

  final apiClient = ApiClient(apiClientConfig);

  final repositories = Repositories(
    WorkCategoryRemoteRepository(apiClient),
    WorkListingRemoteRepository(apiClient));

  return [
    ChangeNotifierProvider(
      create: (final context) => WorkListingViewModel(repositories)
    ),
  ];
}
