import '../../../../domain/work_category.dart';
import 'api_client_path.dart';

class ApiClientWorkCategoriesPath extends ApiClientPath<WorkCategory> {
  ApiClientWorkCategoriesPath()
  : super('workcategories', WorkCategory.fromJson);
}
