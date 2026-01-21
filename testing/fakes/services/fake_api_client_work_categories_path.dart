import 'package:ajudaki_mobile_clean_architecture/entities/services/api_client_config.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/services/paths/api_client_work_categories_path.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/models/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/web/web_result.dart';

class FakeApiClientWorkCategoriesPath implements ApiClientWorkCategoriesPath {
  @override
  String get resource => throw UnimplementedError();

  @override
  ApiClientConfig get apiClientConfig => throw UnimplementedError();

  @override
  WorkCategory Function(Map<String, dynamic> json) get fromJson => throw UnimplementedError();

  @override
  Future<WebResult<Map<String, WorkCategory>>> getAll({Map<String, String>? queryParameters}) async {
    return WebResult.withValue(200, {
        "1": WorkCategory(1, "Eletricista"),
        "2": WorkCategory(2, "Encanador"),
      });
  }
}
