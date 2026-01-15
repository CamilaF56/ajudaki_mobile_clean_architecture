import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/view_models/work_listing_view_model.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../testing/fakes/repositories/fake_work_category_repository.dart';
import '../../../../testing/fakes/repositories/fake_work_listing_repository.dart';

void main() {
  group('init', () {
    test('carrega categorias e serviços', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Response.success([
          WorkListing(
            id: 1,
            title: 'Trocar tomada',
            description: '',
            estimatedPrice: 50,
          ),
        ]);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Response.success([WorkCategory(id: 1, name: 'Elétrica')]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.listings.length, 1);
      expect(viewModel.categories.length, 1);
      expect(viewModel.hasError, false);
    });

    test('seta erro quando serviços falham', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Response.error(Exception('erro serviços'));

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Response.success([WorkCategory(id: 1, name: 'Elétrica')]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.hasError, true);
      expect(viewModel.listings.isEmpty, true);
      expect(viewModel.categories.length, 1);
    });

    test('seta erro quando categorias falham', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Response.success([
          WorkListing(
            id: 1,
            title: 'Trocar tomada',
            description: '',
            estimatedPrice: 50,
          ),
        ]);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Response.error(Exception('erro categorias'));

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.hasError, true);
      expect(viewModel.categories.isEmpty, true);
      expect(viewModel.listings.length, 1);
    });

    test('aceita listas vazias sem erro', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = const Response.success([]);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = const Response.success([]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.hasError, false);
      expect(viewModel.listings.isEmpty, true);
      expect(viewModel.categories.isEmpty, true);
    });
  });

  group('search', () {
    test('busca serviços com termo', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Response.success([
          WorkListing(
            id: 2,
            title: 'Pintar parede',
            description: '',
            estimatedPrice: 200,
          ),
        ]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.search('pintar');

      expect(viewModel.listings.length, 1);
      expect(viewModel.hasError, false);
    });

    test('busca vazia restaura dados', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = const Response.success([]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.search('');

      expect(viewModel.hasError, false);
    });

    test('busca seta erro quando falha', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Response.error(Exception('erro busca'));

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.search('erro');

      expect(viewModel.hasError, true);
      expect(viewModel.listings.isEmpty, true);
    });
  });

  group('filterByCategory', () {
    test('filtra serviços por categoria', () async {
      final category = WorkCategory(id: 1, name: 'Elétrica');

      final listingRepo = FakeWorkListingRepository()
        ..filterResponse = Response.success([
          WorkListing(
            id: 3,
            title: 'Instalar chuveiro',
            description: '',
            estimatedPrice: 120,
          ),
        ]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.filterByCategory(category);

      expect(viewModel.selectedCategory, category);
      expect(viewModel.listings.length, 1);
      expect(viewModel.hasError, false);
    });

    test('filtro seta erro quando falha', () async {
      final category = WorkCategory(id: 1, name: 'Elétrica');

      final listingRepo = FakeWorkListingRepository()
        ..filterResponse = Response.error(Exception('erro filtro'));

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.filterByCategory(category);

      expect(viewModel.hasError, true);
      expect(viewModel.listings.isEmpty, true);
    });
  });

  group('reset & toggleSearch', () {
    test('reset limpa categoria selecionada', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = const Response.success([]);

      final viewModel = WorkListingViewModel(
        workListingRepository: listingRepo,
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.reset();

      expect(viewModel.selectedCategory, null);
    });

    test('toggleSearch ativa e desativa busca', () async {
      final viewModel = WorkListingViewModel(
        workListingRepository: FakeWorkListingRepository(),
        workCategoryRepository: FakeWorkCategoryRepository(),
      );

      await viewModel.toggleSearch();
      expect(viewModel.isSearching, true);

      await viewModel.toggleSearch();
      expect(viewModel.isSearching, false);
      expect(viewModel.searchTerm, '');
    });
  });

  test('loadBackHome limpa categoria e recarrega listagem do cache', () async {
    final listingRepo = FakeWorkListingRepository()
      ..response = Response.success([
        WorkListing(
          id: 10,
          title: 'Consertar torneira',
          description: '',
          estimatedPrice: 80,
        ),
      ]);

    final viewModel = WorkListingViewModel(
      workListingRepository: listingRepo,
      workCategoryRepository: FakeWorkCategoryRepository(),
    );

    await viewModel.filterByCategory(WorkCategory(id: 1, name: 'Hidráulica'));

    expect(viewModel.selectedCategory, isNotNull);

    await viewModel.loadBackHome();

    expect(viewModel.selectedCategory, null);
    expect(viewModel.listings.length, 1);
    expect(viewModel.hasError, false);
  });
}
