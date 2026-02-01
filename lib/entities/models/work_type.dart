import 'model.dart';
import 'work_category.dart';

/// Representa um tipo de trabalho.
class WorkType extends Model {
  /// Cria uma instância de [WorkType].
  WorkType(
    super.id,
    this.name,
    this.workCategory
  );

  /// Cria uma instância de [WorkType] a partir de um JSON.
  factory WorkType.fromJson(final Map<String, dynamic> json) {
    return WorkType(
      json['Id'],
      json['Name'],
      WorkCategory.fromJson(json['WorkCategory']),
    );
  }

  /// Nome do tipo de trabalho.
  final String name;

  /// Área de atuação associada ao tipo de trabalho.
  final WorkCategory? workCategory;
}
