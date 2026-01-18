import '../../../../domain/work_category.dart';
import 'api_client_path.dart';

class ApiClientWorkCategoriesPath extends ApiClientPath<WorkCategory> {
  ApiClientWorkCategoriesPath(final operations)
  : super(
      operations,
      'workcategories',
      WorkCategory.fromJson);
}
