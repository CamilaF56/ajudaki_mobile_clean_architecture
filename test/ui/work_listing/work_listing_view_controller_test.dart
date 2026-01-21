import 'package:ajudaki_mobile_clean_architecture/controllers/work_listing/work_listing_view_controller.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/models/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/models/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/entities/models/work_type.dart';
import 'package:ajudaki_mobile_clean_architecture/use_cases/work_category/list_work_categories_usecase.dart';
import 'package:ajudaki_mobile_clean_architecture/use_cases/work_listing/list_work_listings_usecase.dart';
import 'package:ajudaki_mobile_clean_architecture/use_cases/work_listing/search_work_listings_by_category_usecase.dart';
import 'package:ajudaki_mobile_clean_architecture/use_cases/work_listing/search_work_listings_by_terms_usecase.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../testing/fakes/repositories/fake_work_category_repository.dart';
import '../../../testing/fakes/repositories/fake_work_listing_repository.dart';

void main() {
  group('init', () {
    test('carrega categorias e serviços', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, [
          WorkListing(
            1,
            'Trocar tomada',
            '',
            50
          )
        ]);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Result(true, [WorkCategory(1, 'Elétrica')]);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();

      expect(vm.listings.length, 1);
      expect(vm.categories.length, 1);
      expect(vm.error, null);
    });

    test('seta erro quando serviços falham', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(false);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Result(true, [WorkCategory(1, 'Elétrica')]);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();

      expect(vm.listings.isEmpty, true);
      expect(vm.categories.length, 1);
      expect(vm.error, isNotNull);
    });

    test('seta erro quando categorias falham', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, [
          WorkListing(
            1,
            'Trocar tomada',
            '',
            50
          )
        ]);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Result(false);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();

      expect(vm.error, isNotNull);
      expect(vm.categories.isEmpty, true);
      expect(vm.listings.length, 1);
    });

    test('aceita listas vazias sem erro', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, []);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Result(true, []);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();

      expect(vm.error, null);
      expect(vm.listings.isEmpty, true);
      expect(vm.categories.isEmpty, true);
    });
  });

  group('search', () {
    test('busca serviços com termo', () async {
      final categoryRepo = FakeWorkCategoryRepository();
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, [
          WorkListing(
            2,
            'Pintar parede',
            '',
            200,
          )
        ]);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();
      vm.searchTerm = 'pintar';
      await vm.searchCommand.execute();

      expect(vm.listings.length, 1);
      expect(vm.error, null);
    });

    test('busca vazia restaura dados', () async {
      final categoryRepo = FakeWorkCategoryRepository();
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, []);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();
      vm.searchTerm = '';
      await vm.searchCommand.execute();

      expect(vm.error, null);
    });

    test('busca seta erro quando falha', () async {
      final categoryRepo = FakeWorkCategoryRepository();
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(false);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();
      vm.searchTerm = 'erro';
      await vm.searchCommand.execute();

      expect(vm.error, isNotNull);
      expect(vm.listings.isEmpty, true);
    });
  });

  group('filterByCategory', () {
    test('filtra serviços por categoria', () async {
      final category = WorkCategory(1, '');
      final categoryRepo = FakeWorkCategoryRepository()
      ..response = Result(true, [category]);
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, [
          WorkListing(
            3,
            'Instalar chuveiro',
            '',
            120,
          )
        ]);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm)
      ..filterCategory = category;

      await vm.init();
      await vm.filterByCategoryCommand.execute();

      expect(vm.listings.length, 1);
      expect(vm.error, null);
    });

    test('filtro seta erro quando falha', () async {
      final category = WorkCategory(1, 'Elétrica');
      final categoryRepo = FakeWorkCategoryRepository();
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(false);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm)
      ..filterCategory = category;

      await vm.filterByCategoryCommand.execute();

      expect(vm.error, isNotNull);
      expect(vm.listings.isEmpty, true);
    });
  });

  group('reset & toggleSearch', () {
    test('reset limpa categoria selecionada', () async {
      final categoryRepo = FakeWorkCategoryRepository();
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, []);

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

      await vm.init();
      await vm.reloadCommand.execute();
    });
  });

  test('loadBackHome limpa categoria e recarrega listagem do cache', () async {
    final categoryRepo = FakeWorkCategoryRepository();
    final listingRepo = FakeWorkListingRepository()
      ..response = Result(
        true,
        [
          WorkListing(
            10,
            'Consertar torneira',
            '',
            80,
            WorkType(1, 'type', WorkCategory(1, 'Hidráulica'))
          )]
        );

      final listCategories = ListWorkCategoriesUsecase(categoryRepo);
      final listListings = ListWorkListingsUsecase(listingRepo);
      final searchListingsByCategory =
      SearchWorkListingsByCategoryUsecase(listingRepo);
      final searchListingsByTerm =
      SearchWorkListingsByTermsUsecase(listingRepo);
      
      final vm = WorkListingViewController(
        listCategories,
        listListings,
        searchListingsByCategory,
        searchListingsByTerm);

    await vm.init();

    vm.filterCategory = WorkCategory(1, 'Hidráulica');
    await vm.filterByCategoryCommand.execute();
    await vm.reloadCommand.execute();

    expect(vm.listings.length, 1);
    expect(vm.error, null);
  });
}
