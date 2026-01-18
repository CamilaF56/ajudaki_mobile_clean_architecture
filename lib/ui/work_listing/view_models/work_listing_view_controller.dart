import 'package:flutter/foundation.dart';
import '../../../data/repositories/work_category_repository.dart';
import '../../../data/repositories/work_listing_repository.dart';
import '../../../domain/work_category.dart';
import '../../../domain/work_listing.dart';
import '../../../utils/command.dart';

/// ViewModel responsável por gerenciar o estado da listagem de trabalhos.
///
/// Atua como intermediário entre a camada de UI e os repositórios.
class WorkListingViewModel extends ChangeNotifier {
  /// Cria o ViewModel com os repositórios necessários.
  WorkListingViewModel(
    this._workListingRepository,
    this._workCategoryRepository) {
      loadCategoriesCommand = Command(_loadCategories);
      loadListingsCommand = Command( _loadListings);
      reloadCommand = Command( _reload);
      searchCommand = Command( _search);
      filterByCategoryCommand = Command( _filterByCategory);
    }
    
  final WorkListingRepository _workListingRepository;
  final WorkCategoryRepository _workCategoryRepository;

  bool isInitialized = false;

  bool isLoading = false;
  String? error = null;
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

  late final Command loadCategoriesCommand;
  late final Command loadListingsCommand;

  late final Command reloadCommand;
  late final Command searchCommand;
  late final Command filterByCategoryCommand;

  Future<void> _loadListings() async {
    notifyListeners();

    final result = await _workListingRepository.getAll();

    if (result.isSuccess) {
      listings = result.value!;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    notifyListeners();

    final result = await _workCategoryRepository.getAll();

    if (result.isSuccess) {
      categories = result.value!;
    }

    notifyListeners();
  }

  Future<void> _reload() async {
    error = null;
    isLoading = true;
    searchTerm = null;
    filterCategory = null;
    notifyListeners();

    final response = await _workListingRepository.getAll();

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

    final response = await _workListingRepository.getByTerm(trimmed);

    if (response.isSuccess) {
      listings = response.value!;
    } else {
      listings = [];
    }

    notifyListeners();
  }

  Future<void> _filterByCategory() async {
    if (filterCategory == null) {
      await reloadCommand.execute();
      return;
    }

    notifyListeners();

    final response = await _workListingRepository.getByCategory(filterCategory!.id);

    if (response.isSuccess) {
      listings = response.value!;
    } else {
      listings = [];
    }

    notifyListeners();
  }
}
