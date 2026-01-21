import 'package:flutter/foundation.dart';
import '../entities/repositories/repositories.dart';
import '../entities/models/work_category.dart';
import '../entities/models/work_listing.dart';
import '../utils/command.dart';

/// ViewModel responsável por gerenciar o estado da listagem de trabalhos.
///
/// Atua como intermediário entre a camada de UI e os repositórios.
class WorkListingViewController extends ChangeNotifier {
  /// Cria o ViewModel com os repositórios necessários.
  WorkListingViewController(
    this._listWorkCategoriesUsecase,
    this._listWorkListingsUsecase,
    this._searchWorkListingsByCategoryUsecase,
    this._searchWorkListingsByTermsUsecase);

  final _listWorkCategoriesUsecase;
  final _listWorkListingsUsecase;
  final _searchWorkListingsByCategoryUsecase;
  final _searchWorkListingsByTermsUsecase;

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

    final result = await _listWorkListingsUsecase.execute();

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

    final result = await _listWorkCategoriesUsecase.execute();

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

    _loadListings();

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

    final response = await _searchWorkListingsByTermsUsecase.execute(trimmed);

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
    await _searchWorkListingsByCategoryUsecase.execute(filterCategory!.id);

    if (response.isSuccess) {
      listings = response.value!;
    } else {
      listings = [];
      error = 'Erro de filtro';
    }

    notifyListeners();
  }
}
