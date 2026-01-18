import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../domain/work_category.dart';

/// Widget responsável por exibir os filtros de área de atuação.
///
/// Permite ao usuário selecionar uma área de atuação
/// para filtrar os anúncios exibidos.
class WorkListingCategoryFilter extends StatelessWidget {
  /// Cria o widget de filtros de área de atuação.
  const WorkListingCategoryFilter(
    this.categories,
    this.selectedCategory,
    this.onCategoryChanged,
    [Key? key]
  ) : super(key: key);

  /// Lista de áreas de atuação disponíveis para seleção.
  final List<WorkCategory> categories;

  /// Área de atuação atualmente selecionada.
  final WorkCategory? selectedCategory;

  /// Callback acionado quando a categoria selecionada é alterada.
  final ValueChanged<WorkCategory?> onCategoryChanged;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<WorkCategory>(
              initialValue: selectedCategory,
              hint: const Text('Selecione a categoria do serviço'),
              items: categories
                  .map(
                    (final category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
              onChanged: onCategoryChanged,
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
    properties
      ..add(DiagnosticsProperty<List<WorkCategory>>('categories', categories))
      ..add(
        DiagnosticsProperty<WorkCategory>('selectedCategory', selectedCategory),
      )
      ..add(
        ObjectFlagProperty<ValueChanged<WorkCategory>?>.has(
          'onCategoryChanged',
          onCategoryChanged,
        ),
      );
  }
}
