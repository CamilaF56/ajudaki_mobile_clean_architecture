import '../../../../domain/work_category.dart';
import '../api_client_operations.dart';
import 'api_client_path.dart';

class ApiClientWorkCategoriesPath extends ApiClientPath<WorkCategory> {
  ApiClientWorkCategoriesPath(final ApiClientOperations operations)
  : super(
      operations,
      'workcategories',
      WorkCategory.fromJson);
}
