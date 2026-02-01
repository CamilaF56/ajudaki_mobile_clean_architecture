import 'package:flutter/foundation.dart';
import '../../entities/models/work_category.dart';
import '../../entities/models/work_listing.dart';
import '../../use_cases/work_category/list_work_categories_usecase.dart';
import '../../use_cases/work_listing/list_work_listings_usecase.dart';
import '../../use_cases/work_listing/search_work_listings_by_category_usecase.dart';
import '../../use_cases/work_listing/search_work_listings_by_terms_usecase.dart';
import '../../utils/command.dart';

/// ViewModel responsável por gerenciar o estado da listagem de trabalhos.
///
/// Atua como intermediário entre a camada de UI e os repositórios.
class WorkListingViewController extends ChangeNotifier {
  /// Cria o ViewModel com os repositórios necessários.
  WorkListingViewController(
    this._listCategoriesUsecase,
    this._listListingsUsecase,
    this._searchListingsByCategoryUsecase,
    this._searchListingsByTermsUsecase);

  final ListWorkCategoriesUsecase _listCategoriesUsecase;
  final ListWorkListingsUsecase _listListingsUsecase;
  final SearchWorkListingsByCategoryUsecase _searchListingsByCategoryUsecase;
  final SearchWorkListingsByTermsUsecase _searchListingsByTermsUsecase;

  late final loadCategoriesCommand = Command(_loadCategories);
  late final loadListingsCommand = Command( _loadListings);
  late final reloadCommand = Command( _reload);
  late final searchCommand = Command( _search);
  late final filterByCategoryCommand = Command( _filterByCategory);

  bool isInitialized = false;

  bool isLoading = false;
  String? error;
  List<WorkListing> listings = [];
  List<WorkCategory> categories = [];
  String? searchTerm;
  WorkCategory? filterCategory;

  Future<void> init() async {
    if (isInitialized) {
      return;
    }

    isInitialized = true;

    await loadCategoriesCommand.execute();
    await loadListingsCommand.execute();
  }

  Future<void> _loadListings() async {
    notifyListeners();

    final result = await _listListingsUsecase.execute();

    if (result.isSuccess) {
      listings = result.value!;
    } else {
      error = 'Erro de serviços';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    notifyListeners();

    final result = await _listCategoriesUsecase.execute();

    if (result.isSuccess) {
      categories = result.value!;
    } else {
      error = 'Erro de categorias';
    }

    notifyListeners();
  }

  Future<void> _reload() async {
    error = null;
    isLoading = true;
    searchTerm = null;
    filterCategory = null;
    notifyListeners();

    final response = await _listListingsUsecase.execute();

    if (response.isSuccess) {
      listings = response.value!;
    } else {
      listings = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> _search() async {
    final trimmed = searchTerm?.trim();

    if (trimmed == null || trimmed.isEmpty) {
      await reloadCommand.execute();
      return;
    }

    notifyListeners();

    final response = await _searchListingsByTermsUsecase.execute(trimmed);

    if (response.isSuccess) {
      listings = response.value!;
    } else {
      listings = [];
      error = 'Erro de busca';
    }

    notifyListeners();
  }

  Future<void> _filterByCategory() async {
    if (filterCategory == null) {
      await reloadCommand.execute();
      return;
    }

    notifyListeners();

    final response =
    await _searchListingsByCategoryUsecase.execute(filterCategory!.id);

    if (response.isSuccess) {
      listings = response.value!;
    } else {
      listings = [];
      error = 'Erro de filtro';
    }

    notifyListeners();
  }
}
