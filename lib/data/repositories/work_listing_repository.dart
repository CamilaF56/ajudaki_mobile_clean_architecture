import '../../domain/work_listing.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

class WorkListingRepository {
  WorkListingRepository();

  List<WorkListing>? cache;

  Future<Response<List<WorkListing>>> getAll() async {
    if (cache != null) {
      return Future.value(Response(true, cache!));
    }

    final webResponse = await ApiClient.workListings.getAll();

    if (webResponse.isSuccess) {
      cache = webResponse.body?.values.toList();
    }

    return Response<List<WorkListing>>(
      webResponse.isSuccess,
      webResponse.body?.values.toList()
    );
  }

  Future<Response<List<WorkListing>>> getByCategory(
    final int categoryId) async {
      if (cache != null) {
      final filtered = cache!
          .where(
            (final workListing) =>
                workListing.workType?.workCategory?.id == categoryId,
          )
          .toList();

      return Future.value(Response(true, filtered));
    }

    final queryParameters = <String, String?>{};
    queryParameters['workCategoryId'] = categoryId.toString();
    final webResponse = await ApiClient.workListings.search(queryParameters);

    return Response<List<WorkListing>>(
      webResponse.isSuccess,
      webResponse.body?.values.toList()
    );
  }

  Future<Response<List<WorkListing>>> getByTerm(
    final String terms) async {
      if (cache != null) {
      final filtered = cache!
          .where(
            (final workListing) =>
                workListing.title.toLowerCase().contains(terms.toLowerCase()),
          )
          .toList();

      return Future.value(Response(true, filtered));
    }

    final queryParameters = <String, String?>{};
    queryParameters['terms'] = terms;

    final webResponse = await ApiClient.workListings.search(queryParameters);

    return Response(
      webResponse.isSuccess,
      webResponse.body!.values.toList());
  }
}
