import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/work_listing/work_listing_view_controller.dart';
import '../../../entities/models/work_category.dart';

/// Widget responsável por exibir os filtros de área de atuação.
///
/// Permite ao usuário selecionar uma área de atuação
/// para filtrar os anúncios exibidos.
class WorkListingCategoryFilter extends StatelessWidget {
  /// Cria o widget de filtros de área de atuação.
  const WorkListingCategoryFilter(
    this.options,
    [final Key? key]
  ) : super(key: key);

  final List<WorkCategory> options;

  @override
  Widget build(final BuildContext context) {
    final vm = context.watch<WorkListingViewController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<WorkCategory>(
              initialValue: vm.filterCategory,
              hint: const Text('Selecione a categoria do serviço'),
              items: options
                  .map(
                    (final category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
                  onChanged: (final category) async {
                    if (vm.filterCategory == category) {
                      await vm.reloadCommand.execute();
                    } else {
                      vm.filterCategory = category;
                      await vm.filterByCategoryCommand.execute();
                    }
                  },
                  decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(171, 186, 255, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<WorkCategory>>(
      'options', options));
  }
}
