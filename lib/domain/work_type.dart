import 'model.dart';
import 'work_category.dart';

/// Representa um tipo de trabalho.
class WorkType extends Model {
  /// Cria uma instância de [WorkType].
  WorkType({required super.id, required this.name, required this.workCategory});

  /// Cria uma instância de [WorkType] a partir de um JSON.
  factory WorkType.fromJson(final Map<String, dynamic> json) {
    return WorkType(
      id: json['Id'],
      name: json['Name'],
      workCategory: WorkCategory.fromJson(json['WorkCategory']),
    );
  }

  /// Nome do tipo de trabalho.
  final String name;

  /// Área de atuação associada ao tipo de trabalho.
  final WorkCategory? workCategory;
}
