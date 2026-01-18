import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../ui/work_listing/view_models/work_listing_view_model.dart';
import 'data/repositories/repositories.dart';
import 'data/repositories/work_listing_repository.dart';
import 'data/repositories/work_category_repository.dart';
import 'data/repositories/remote/work_category_remote_repository.dart';
import 'data/repositories/remote/work_listing_remote_repository.dart';
import 'data/services/api/api_client_config.dart';

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

  Repositories repositories = Repositories();
  repositories.add<WorkCategoryRepository>(WorkCategoryRemoteRepository(apiClientConfig));
  repositories.add<WorkListingRepository>(WorkListingRemoteRepository(apiClientConfig));

  return [
    Provider.value(value: repositories),

    ChangeNotifierProvider(
      create: (final context)
      => WorkListingViewModel(
        repositories.get<WorkListingRepository>(),
        repositories.get<WorkCategoryRepository>()
      )
    ),
  ];
}
