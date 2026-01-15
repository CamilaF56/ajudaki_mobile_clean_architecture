import 'package:ajudaki_mobile_clean_architecture/models/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/models/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/view_models/work_listing_view_model.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/widgets/work_listing_entry.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/widgets/work_listing_screen.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../../../../testing/fakes/repositories/fake_work_category_repository.dart';
import '../../../../testing/fakes/repositories/fake_work_listing_repository.dart';

void main() {
  Widget makeTestableWidget(final WorkListingViewModel vm) {
    return MaterialApp(
      home: ChangeNotifierProvider.value(
        value: vm,
        child: const WorkListingScreen(),
      ),
    );
  }

  testWidgets('mostra lista de serviços quando sucesso', (final tester) async {
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

    final vm = WorkListingViewModel(
      workListingRepository: listingRepo,
      workCategoryRepository: categoryRepo,
    );

    await tester.pumpWidget(makeTestableWidget(vm));

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(WorkListingEntry), findsOneWidget);
  });

  testWidgets('mostra mensagem de erro quando falha', (final tester) async {
    final listingRepo = FakeWorkListingRepository()
      ..response = Response.error(Exception('erro'));

    final categoryRepo = FakeWorkCategoryRepository()
      ..response = const Response.success([]);

    final vm = WorkListingViewModel(
      workListingRepository: listingRepo,
      workCategoryRepository: categoryRepo,
    );

    await tester.pumpWidget(makeTestableWidget(vm));
    await tester.pump();
    await tester.pump();

    expect(find.text('Erro ao carregar os serviços'), findsOneWidget);
  });

  testWidgets('mostra estado vazio quando não há serviços', (
    final tester,
  ) async {
    final listingRepo = FakeWorkListingRepository()
      ..response = const Response.success([]);

    final categoryRepo = FakeWorkCategoryRepository()
      ..response = const Response.success([]);

    final vm = WorkListingViewModel(
      workListingRepository: listingRepo,
      workCategoryRepository: categoryRepo,
    );

    await tester.pumpWidget(makeTestableWidget(vm));
    await tester.pump();
    await tester.pump();

    expect(find.text('Nenhum serviço encontrado'), findsOneWidget);
  });
}
