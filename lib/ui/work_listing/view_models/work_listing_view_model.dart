import 'package:flutter/foundation.dart';
import '../../../data/repositories/work_category_repository.dart';
import '../../../data/repositories/work_listing_repository.dart';
import '../../../domain/work_category.dart';
import '../../../domain/work_listing.dart';
import '../../../utils/response.dart';

/// ViewModel responsável por gerenciar o estado da listagem de trabalhos.
///
/// Atua como intermediário entre a camada de UI e os repositórios.
class WorkListingViewModel extends ChangeNotifier {
  /// Cria o ViewModel com os repositórios necessários.
  WorkListingViewModel({
    required final WorkListingRepository workListingRepository,
    required final WorkCategoryRepository workCategoryRepository,
  }) : _workListingRepository = workListingRepository,
       _workCategoryRepository = workCategoryRepository;

  /// Repositório de anúncios de trabalho.
  final WorkListingRepository _workListingRepository;

  /// Repositório de áreas de atuação.
  final WorkCategoryRepository _workCategoryRepository;

  // ---------- STATE ----------

  /// Lista atual de anúncios de trabalho.
  List<WorkListing> _listings = [];

  /// Lista de áreas de atuação disponíveis.
  List<WorkCategory> _categories = [];

  /// Área de atuação atualmente selecionada para filtro.
  WorkCategory? _selectedCategory;

  /// Indica se a UI está no modo de busca.
  bool _isSearching = false;

  /// Termo atual de busca.
  String _searchTerm = '';

  /// Indica se uma operação está em andamento.
  bool _isLoading = false;

  /// Indica se o ViewModel já foi inicializado.
  bool _isInitialized = false;

  /// Indica erro ao carregar anúncios.
  bool _hasListingError = false;

  /// Indica erro ao carregar áreas de atuação.
  bool _hasCategoryError = false;

  // ---------- GETTERS ----------

  /// Lista de anúncios de trabalho.
  List<WorkListing> get listings => _listings;

  /// Lista de áreas de atuação disponíveis.
  List<WorkCategory> get categories => _categories;

  /// Área de atuação selecionada atualmente.
  WorkCategory? get selectedCategory => _selectedCategory;

  /// Indica se o modo de busca está ativo.
  bool get isSearching => _isSearching;

  /// Termo de busca atual.
  String get searchTerm => _searchTerm.trim();

  /// Indica se há carregamento em progresso.
  bool get isLoading => _isLoading;

  /// Indica se ocorreu algum erro.
  bool get hasError => _hasListingError || _hasCategoryError;

  /// Indica erro na listagem de trabalhos.
  bool get hasListingError => _hasListingError;

  /// Indica erro no carregamento de áreas de atuação.
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

  // ---------- LOADERS ----------

  /// Carrega todas as áreas de atuação.
  Future<void> loadCategories() async {
    _isLoading = true;
    _hasCategoryError = false;
    notifyListeners();

    final response = await _workCategoryRepository.getAll();

    if (response is Success<List<WorkCategory>>) {
      _categories = response.value;
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

    if (response is Success<List<WorkListing>>) {
      _listings = response.value;
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

    if (response is Success<List<WorkListing>>) {
      _listings = response.value;
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

    if (response is Success<List<WorkListing>>) {
      _listings = response.value;
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

    if (response is Success<List<WorkListing>>) {
      _listings = response.value;
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
