import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'entities/repositories/remote/work_category_remote_repository.dart';
import 'entities/repositories/remote/work_listing_remote_repository.dart';
import 'entities/repositories/repositories.dart';
import 'entities/services/api_client.dart';
import 'entities/services/api_client_config.dart';
import 'controllers/work_listing/work_listing_view_controller.dart';
import 'use_cases/work_category/list_work_categories_usecase.dart';
import 'use_cases/work_listing/list_work_listings_usecase.dart';
import 'use_cases/work_listing/search_work_listings_by_terms_usecase.dart';
import 'use_cases/work_listing/search_work_listings_by_category_usecase.dart';

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
    Provider.value(value: ListWorkCategoriesUsecase(repositories.workCategories)),
    Provider.value(value: ListWorkListingsUsecase(repositories.workListings)),
    Provider.value(value: SearchWorkListingsByCategoryUsecase(repositories.workListings)),
    Provider.value(value: SearchWorkListingsByTermsUsecase(repositories.workListings)),

    ChangeNotifierProvider(
      create: (final context) => WorkListingViewController(
        context.read<ListWorkCategoriesUsecase>(),
        context.read<ListWorkListingsUsecase>(),
        context.read<SearchWorkListingsByCategoryUsecase>(),
        context.read<SearchWorkListingsByTermsUsecase>())
    ),
  ];
}
