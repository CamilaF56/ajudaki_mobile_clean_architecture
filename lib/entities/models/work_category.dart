import 'model.dart';

/// Representa uma área de atuação.
class WorkCategory extends Model {
  /// Cria uma instância de [WorkCategory].
  WorkCategory(
    super.id,
    this.name);

  /// Cria uma instância de [WorkCategory] a partir de um JSON.
  factory WorkCategory.fromJson(final Map<String, dynamic> json) {
    return WorkCategory(
      json['Id'],
      json['Name']
    );
  }

  /// Nome da área de atuação.
  final String name;
}
