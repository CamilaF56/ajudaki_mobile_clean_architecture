import 'package:ajudaki_mobile_clean_architecture/domain/work_category.dart';
import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/work_listing_view_controller.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/widgets/work_listing_entry.dart';
import 'package:ajudaki_mobile_clean_architecture/ui/work_listing/widgets/work_listing_screen.dart';
import 'package:ajudaki_mobile_clean_architecture/utils/result.dart';
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
      ..response = Result(true,[
        WorkListing(
          1,
          'Trocar tomada',
          '',
          50
        ),
      ]);

    final categoryRepo = FakeWorkCategoryRepository()
      ..response = Result(true, [WorkCategory(1, 'Elétrica')]);

    final vm = WorkListingViewModel(
      listingRepo,
      categoryRepo,
    );

    await tester.pumpWidget(makeTestableWidget(vm));

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(WorkListingEntry), findsOneWidget);
  });

  testWidgets('mostra mensagem de erro quando falha', (final tester) async {
    final listingRepo = FakeWorkListingRepository()
      ..response = Result(false);

    final categoryRepo = FakeWorkCategoryRepository()
      ..response = Result(true, []);

    final vm = WorkListingViewModel(
      listingRepo,
      categoryRepo,
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
      ..response = Result(true, []);

    final categoryRepo = FakeWorkCategoryRepository()
      ..response = Result(true, []);

    final vm = WorkListingViewModel(
      listingRepo,
      categoryRepo,
    );

    await tester.pumpWidget(makeTestableWidget(vm));
    await tester.pump();
    await tester.pump();

    expect(find.text('Nenhum serviço encontrado'), findsOneWidget);
  });
}
