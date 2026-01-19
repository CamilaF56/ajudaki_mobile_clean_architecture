import 'package:ajudaki_mobile_clean_architecture/data/repositories/repositories.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_type.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/work_listing_view_controller.dart';
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
      final apiClient = Repositories(categoryRepo, listingRepo);

      final viewModel = WorkListingViewModel(apiClient);

      await viewModel.init();

      expect(viewModel.listings.length, 1);
      expect(viewModel.categories.length, 1);
      expect(viewModel.error, null);
    });

    test('seta erro quando serviços falham', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(false);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Result(true, [WorkCategory(1, 'Elétrica')]);
      final apiClient = Repositories(categoryRepo, listingRepo);

      final viewModel = WorkListingViewModel(apiClient);

      await viewModel.init();

      expect(viewModel.error, isNotNull);
      expect(viewModel.listings.isEmpty, true);
      expect(viewModel.categories.length, 1);
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
      final apiClient = Repositories(categoryRepo, listingRepo);

      final viewModel = WorkListingViewModel(apiClient);

      await viewModel.init();

      expect(viewModel.error, isNotNull);
      expect(viewModel.categories.isEmpty, true);
      expect(viewModel.listings.length, 1);
    });

    test('aceita listas vazias sem erro', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, []);

      final categoryRepo = FakeWorkCategoryRepository()
        ..response = Result(true, []);
      final apiClient = Repositories(categoryRepo, listingRepo);

      final viewModel = WorkListingViewModel(apiClient);

      await viewModel.init();

      expect(viewModel.error, null);
      expect(viewModel.listings.isEmpty, true);
      expect(viewModel.categories.isEmpty, true);
    });
  });

  group('search', () {
    test('busca serviços com termo', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, [
          WorkListing(
            2,
            'Pintar parede',
            '',
            200,
          )
        ]);

      final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);
      final viewModel = WorkListingViewModel(apiClient)
      ..searchTerm = 'pintar';

      await viewModel.searchCommand.execute();

      expect(viewModel.listings.length, 1);
      expect(viewModel.error, null);
    });

    test('busca vazia restaura dados', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, []);
      final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);

      final viewModel = WorkListingViewModel(apiClient)
      ..searchTerm = '';

      await viewModel.searchCommand.execute();

      expect(viewModel.error, null);
    });

    test('busca seta erro quando falha', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(false);
      final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);

      final viewModel = WorkListingViewModel(apiClient)
      ..searchTerm = 'erro';

      await viewModel.searchCommand.execute();

      expect(viewModel.error, isNotNull);
      expect(viewModel.listings.isEmpty, true);
    });
  });

  group('filterByCategory', () {
    test('filtra serviços por categoria', () async {
      final category = WorkCategory(1, 'Elétrica');

      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, [
          WorkListing(
            3,
            'Instalar chuveiro',
            '',
            120,
          )
        ]);
      final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);

      final viewModel = WorkListingViewModel(apiClient)
      ..filterCategory = category;

      await viewModel.filterByCategoryCommand.execute();

      expect(viewModel.listings.length, 1);
      expect(viewModel.error, null);
    });

    test('filtro seta erro quando falha', () async {
      final category = WorkCategory(1, 'Elétrica');

      final listingRepo = FakeWorkListingRepository()
        ..response = Result(false);
      final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);

      final viewModel = WorkListingViewModel(apiClient)
      ..filterCategory = category;

      await viewModel.filterByCategoryCommand.execute();

      expect(viewModel.error, isNotNull);
      expect(viewModel.listings.isEmpty, true);
    });
  });

  group('reset & toggleSearch', () {
    test('reset limpa categoria selecionada', () async {
      final listingRepo = FakeWorkListingRepository()
        ..response = Result(true, []);

      final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);

      final viewModel = WorkListingViewModel(apiClient);

      await viewModel.reloadCommand.execute();
    });
  });

  test('loadBackHome limpa categoria e recarrega listagem do cache', () async {
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

    final apiClient = Repositories(FakeWorkCategoryRepository(), listingRepo);
    final viewModel = WorkListingViewModel(apiClient)
    ..filterCategory = WorkCategory(1, 'Hidráulica');

    await viewModel.filterByCategoryCommand.execute();

    await viewModel.reloadCommand.execute();

    expect(viewModel.listings.length, 1);
    expect(viewModel.error, null);
  });
}
