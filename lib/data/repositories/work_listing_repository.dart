import '../../domain/work_listing.dart';
import '../../utils/response.dart';
import '../services/api/api_client.dart';

class WorkListingRepository {
  Future<Response<List<WorkListing>>> getAll() async {
    final webResponse = await ApiClient.workListings.getAll();

    if (!webResponse.isSuccess) {
      return Response.error(Exception(webResponse.statusCode.toString()));
    }

    return Response.success(webResponse.body!.values.toList());
  }

  Future<Response<List<WorkListing>>> getByCategory(
    final int categoryId
  ) async {
    final queryParameters = <String, String?>{};
    queryParameters['workCategoryId'] = categoryId.toString();

    final webResponse = await ApiClient.workListings.search(queryParameters);

    if (!webResponse.isSuccess) {
      return Response.error(Exception(webResponse.statusCode.toString()));
    }

    return Response.success(webResponse.body!.values.toList());
  }

  Future<Response<List<WorkListing>>> getByTerm(
    final String terms) async {
      final queryParameters = <String, String?>{};
    queryParameters['terms'] = terms;

    final webResponse = await ApiClient.workListings.search(queryParameters);

    if (!webResponse.isSuccess) {
      return Response.error(Exception(webResponse.statusCode.toString()));
    }

    return Response.success(webResponse.body!.values.toList());
  }
}
