import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../ui/work_listing/view_models/work_listing_view_model.dart';
import 'data/repositories/work_category_repository.dart';
import 'data/repositories/work_listing_repository.dart';
import 'data/services/api/api_client.dart';

/// Conjunto de providers responsáveis por configurar o acesso remoto.
///
/// Centraliza a criação e injeção de dependências relacionadas
/// à comunicação com a API e aos repositórios.
List<SingleChildWidget> get providersRemote {
  return [
    /// Provider do cliente de API.
    Provider.value(value: ApiClient),

    /// Provider do repositório de categorias de trabalho.
    Provider(create: (_) => WorkCategoryRepository),

    /// Provider do repositório de anúncios de trabalho.
    Provider(create: (_) => WorkListingRepository),

    /// Provider do ViewModel responsável pela listagem de trabalhos.
    ChangeNotifierProvider(
      create: (final context) => WorkListingViewModel(
        context.read(),
        context.read(),
      ),
    ),
  ];
}
