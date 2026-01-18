import 'package:flutter/foundation.dart';
import '../../../data/repositories/work_category_repository.dart';
import '../../../data/repositories/work_listing_repository.dart';
import '../../../domain/work_category.dart';
import '../../../domain/work_listing.dart';

/// ViewModel responsável por gerenciar o estado da listagem de trabalhos.
///
/// Atua como intermediário entre a camada de UI e os repositórios.
class WorkListingViewModel extends ChangeNotifier {
  /// Cria o ViewModel com os repositórios necessários.
  WorkListingViewModel(
    this._workListingRepository,
    this._workCategoryRepository);
    
  final WorkListingRepository _workListingRepository;
  final WorkCategoryRepository _workCategoryRepository;

  // ---------- STATE ----------

  List<WorkListing> _listings = [];
  List<WorkCategory> _categories = [];
  WorkCategory? _selectedCategory;
  bool _isSearching = false;
  String _searchTerm = '';
  bool _isLoading = false;
  bool _isInitialized = false;
  bool _hasListingError = false;
  bool _hasCategoryError = false;

  // ---------- GETTERS ----------

  List<WorkListing> get listings => _listings;
  List<WorkCategory> get categories => _categories;
  WorkCategory? get selectedCategory => _selectedCategory;
  bool get isSearching => _isSearching;
  String get searchTerm => _searchTerm.trim();
  bool get isLoading => _isLoading;
  bool get hasError => _hasListingError || _hasCategoryError;
  bool get hasListingError => _hasListingError;
  bool get hasCategoryError => _hasCategoryError;

  // ---------- LIFECYCLE ----------

  /// Inicializa o ViewModel carregando áreas de atuação e anúncios.
  ///
  /// Garante que a inicialização ocorra apenas uma vez.
  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    await loadCategories();
    await loadAllListings();
  }

  /// Carrega todas as áreas de atuação.
  Future<void> loadCategories() async {
    _isLoading = true;
    _hasCategoryError = false;
    notifyListeners();

    final response = await _workCategoryRepository.getAll();

    if (response.isSuccess) {
      _categories = response.value!;
    } else {
      _hasCategoryError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Carrega todos os anúncios de trabalho.
  Future<void> loadAllListings() async {
    _isLoading = true;
    _hasListingError = false;
    notifyListeners();

    final response = await _workListingRepository.getAll();

    if (response.isSuccess) {
      _listings = response.value!;
    } else {
      _listings = [];
      _hasListingError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Retorna à tela inicial removendo filtros aplicados.
  Future<void> loadBackHome() async {
    _selectedCategory = null;
    await reload();
  }

  // ---------- SEARCH ----------

  /// Realiza a busca de anúncios pelo termo informado.
  Future<void> search(final String term) async {
    final trimmed = term.trim();

    if (trimmed.isEmpty) {
      await reload();
      return;
    }

    _isLoading = true;
    _hasListingError = false;
    notifyListeners();

    final response = await _workListingRepository.getByTerm(trimmed);

    if (response.isSuccess) {
      _listings = response.value!;
    } else {
      _listings = [];
      _hasListingError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ---------- FILTER ----------

  /// Filtra os anúncios pela área de atuação selecionada.
  Future<void> filterByCategory(final WorkCategory? category) async {
    _selectedCategory = category;

    if (category == null) {
      await reload();
      return;
    }

    _isLoading = true;
    _hasListingError = false;
    notifyListeners();

    final response = await _workListingRepository.getByCategory(category.id);

    if (response.isSuccess) {
      _listings = response.value!;
    } else {
      _listings = [];
      _hasListingError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ---------- RESET ----------

  /// Remove filtros e recarrega os dados.
  Future<void> reset() async {
    _selectedCategory = null;
    await reload();
  }

  /// Recarrega todos os anúncios de trabalho.
  Future<void> reload() async {
    _isLoading = true;
    _hasListingError = false;
    notifyListeners();

    final response = await _workListingRepository.getAll();

    if (response.isSuccess) {
      _listings = response.value!;
    } else {
      _listings = [];
      _hasListingError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ---------- SEARCH UI ----------

  /// Alterna o modo de busca da interface.
  ///
  /// Ao desativar, limpa o termo de busca e recarrega os dados.
  Future<void> toggleSearch() async {
    _isSearching = !_isSearching;

    if (!_isSearching) {
      _searchTerm = '';
      await reset();
    }

    notifyListeners();
  }

  /// Define o termo de busca.
  set searchTerm(final String value) {
    _searchTerm = value;
  }
}
