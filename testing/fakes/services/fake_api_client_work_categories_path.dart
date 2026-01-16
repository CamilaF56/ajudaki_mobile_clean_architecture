import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'fake_api_client_path.dart';

class FakeApiClientWorkCategoriesPath extends FakeApiClientPath<WorkCategory> {
  FakeApiClientWorkCategoriesPath()
    : super({
        "1": WorkCategory(id: 1, name: "Eletricista"),
        "2": WorkCategory(id: 2, name: "Encanador"),
      });
}
