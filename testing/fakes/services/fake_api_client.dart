import 'package:ajudaki_mobile_clean_architecture/data/services/api/api_client.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';

class FakeApiClient extends ApiClient {
  FakeApiClient() : super();

  @override
  Future<Response<Map<int, WorkListing>>> getWorkListings() async {
    return Response.success({
      1: WorkListing(
        id: 1,
        title: 'Trocar tomada',
        description: '',
        estimatedPrice: 50,
      ),
      2: WorkListing(
        id: 2,
        title: 'Instalar lâmpada',
        description: '',
        estimatedPrice: 40,
      ),
    });
  }

  @override
  Future<Response<Map<int, WorkListing>>> searchWorkListings(
    String? terms,
    int? workCategoryId,
  ) async {
    final result = await getWorkListings();
    final normalized = terms?.toLowerCase();

    return switch (result) {
        Success(value: final map) => () {
          var entries = map.entries;

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

          return Response.success(
            Map.fromEntries(entries),
          );
        }(),
        Error(error: final error) => Response.error(error),
      };
  }

  @override
  Future<Response<Map<int, WorkCategory>>> getWorkCategories() async {
    return Response.success({
      1: WorkCategory(
        id: 1,
        name: 'Elétrica'
      ),
      2: WorkCategory(
        id: 2,
        name: 'Hidráulica'
      ),
    });
  }
}