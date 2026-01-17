import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/view_models/work_listing_view_model.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../testing/fakes/repositories/fake_work_category_repository.dart';
import '../../../../testing/fakes/repositories/fake_work_listing_repository.dart';

void main() {
  group('init', () {
    test('carrega categorias e serviços', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(true, [
          WorkListing(
            1,
            'Trocar tomada',
            '',
            50
          )
        ]);

      final categoryRepo = FakeWorkCategoryRepository(null)
        ..response = Result(true, [WorkCategory(1, 'Elétrica')]);

      final viewModel = WorkListingViewModel(
        listingRepo,
        categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.listings.length, 1);
      expect(viewModel.categories.length, 1);
      expect(viewModel.hasError, false);
    });

    test('seta erro quando serviços falham', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(false);

      final categoryRepo = FakeWorkCategoryRepository(null)
        ..response = Result(true, [WorkCategory(1, 'Elétrica')]);

      final viewModel = WorkListingViewModel(
        listingRepo,
        categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.hasError, true);
      expect(viewModel.listings.isEmpty, true);
      expect(viewModel.categories.length, 1);
    });

    test('seta erro quando categorias falham', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(true, [
          WorkListing(
            1,
            'Trocar tomada',
            '',
            50
          )
        ]);

      final categoryRepo = FakeWorkCategoryRepository(null)
        ..response = Result(false);

      final viewModel = WorkListingViewModel(
        listingRepo,
        categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.hasError, true);
      expect(viewModel.categories.isEmpty, true);
      expect(viewModel.listings.length, 1);
    });

    test('aceita listas vazias sem erro', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(true, []);

      final categoryRepo = FakeWorkCategoryRepository(null)
        ..response = Result(true, []);

      final viewModel = WorkListingViewModel(
        listingRepo,
        categoryRepo,
      );

      await viewModel.init();

      expect(viewModel.hasError, false);
      expect(viewModel.listings.isEmpty, true);
      expect(viewModel.categories.isEmpty, true);
    });
  });

  group('search', () {
    test('busca serviços com termo', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(true, [
          WorkListing(
            2,
            'Pintar parede',
            '',
            200,
          )
        ]);

      final viewModel = WorkListingViewModel(
        listingRepo,
        FakeWorkCategoryRepository(null),
      );

      await viewModel.search('pintar');

      expect(viewModel.listings.length, 1);
      expect(viewModel.hasError, false);
    });

    test('busca vazia restaura dados', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(true, []);

      final viewModel = WorkListingViewModel(
        listingRepo,
        FakeWorkCategoryRepository(null),
      );

      await viewModel.search('');

      expect(viewModel.hasError, false);
    });

    test('busca seta erro quando falha', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(false);

      final viewModel = WorkListingViewModel(
        listingRepo,
        FakeWorkCategoryRepository(null),
      );

      await viewModel.search('erro');

      expect(viewModel.hasError, true);
      expect(viewModel.listings.isEmpty, true);
    });
  });

  group('filterByCategory', () {
    test('filtra serviços por categoria', () async {
      final category = WorkCategory(1, 'Elétrica');

      final listingRepo = FakeWorkListingRepository(null)
        ..filterResponse = Result(true, [
          WorkListing(
            3,
            'Instalar chuveiro',
            '',
            120,
          )
        ]);

      final viewModel = WorkListingViewModel(
        listingRepo,
        FakeWorkCategoryRepository(null),
      );

      await viewModel.filterByCategory(category);

      expect(viewModel.selectedCategory, category);
      expect(viewModel.listings.length, 1);
      expect(viewModel.hasError, false);
    });

    test('filtro seta erro quando falha', () async {
      final category = WorkCategory(1, 'Elétrica');

      final listingRepo = FakeWorkListingRepository(null)
        ..filterResponse = Result(false);

      final viewModel = WorkListingViewModel(
        listingRepo,
        FakeWorkCategoryRepository(null),
      );

      await viewModel.filterByCategory(category);

      expect(viewModel.hasError, true);
      expect(viewModel.listings.isEmpty, true);
    });
  });

  group('reset & toggleSearch', () {
    test('reset limpa categoria selecionada', () async {
      final listingRepo = FakeWorkListingRepository(null)
        ..response = Result(true, []);

      final viewModel = WorkListingViewModel(
        listingRepo,
        FakeWorkCategoryRepository(null),
      );

      await viewModel.reset();

      expect(viewModel.selectedCategory, null);
    });

    test('toggleSearch ativa e desativa busca', () async {
      final viewModel = WorkListingViewModel(
        FakeWorkListingRepository(null),
        FakeWorkCategoryRepository(null),
      );

      await viewModel.toggleSearch();
      expect(viewModel.isSearching, true);

      await viewModel.toggleSearch();
      expect(viewModel.isSearching, false);
      expect(viewModel.searchTerm, '');
    });
  });

  test('loadBackHome limpa categoria e recarrega listagem do cache', () async {
    final listingRepo = FakeWorkListingRepository(null)
      ..response = Result(
        true,
        [
          WorkListing(
            10,
            'Consertar torneira',
            '',
            80
          )]
        );

    final viewModel = WorkListingViewModel(
      listingRepo,
      FakeWorkCategoryRepository(null),
    );

    await viewModel.filterByCategory(WorkCategory(1, 'Hidráulica'));

    expect(viewModel.selectedCategory, isNotNull);

    await viewModel.loadBackHome();

    expect(viewModel.selectedCategory, null);
    expect(viewModel.listings.length, 1);
    expect(viewModel.hasError, false);
  });
}
