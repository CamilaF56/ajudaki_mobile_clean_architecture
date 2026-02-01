import 'package:ajudaki_mobile_clean_architecture/entities/services/api_client_config.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/services/paths/api_client_work_listings_path.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/models/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/web/web_result.dart';

class FakeApiClientWorkListingsPath implements ApiClientWorkListingsPath {
  @override
  ApiClientConfig get apiClientConfig => throw UnimplementedError();

  @override
  String get resource => throw UnimplementedError();

  @override
  WorkListing Function(Map<String, dynamic> json) get fromJson => throw UnimplementedError();

  @override
  Future<WebResult<Map<String, WorkListing>>> getAll({Map<String, String>? queryParameters}) async {
    return WebResult.withValue(200,{
      "1": WorkListing(1,"Trocar tomada", "", 50),
      "2": WorkListing(2, "Instalar lâmpada", "", 40)
    });
  }

  @override
  Future<WebResult<Map<String, WorkListing>>> search({
    String? workCategoryId,
    String? terms}) async {
    final result = await getAll();

    if (!result.isSuccess) {
      return WebResult.withValue(-1, null);
    }

    final normalized = terms?.toLowerCase();

    var entries = result.value!.entries;

    if (normalized != null && normalized.isNotEmpty) {
      entries = entries.where(
        (e) => e.value.title.toLowerCase().contains(normalized),
      );
    }

    if (workCategoryId != null) {
      entries = entries.where(
        (e) =>
            e.value.workType?.workCategory != null &&
            e.value.workType?.workCategory!.id == workCategoryId,
      );
    }

    return WebResult.withValue(200,
      Map.fromEntries(entries),
    );
  }
}
