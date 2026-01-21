import '../../models/work_category.dart';
import 'api_client_path.dart';

class ApiClientWorkCategoriesPath extends ApiClientPath<WorkCategory> {
  ApiClientWorkCategoriesPath(final apiClientConfig)
    : super (
    apiClientConfig,
    'workcategories',
    WorkCategory.fromJson);
}
