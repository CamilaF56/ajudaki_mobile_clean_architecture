import 'model.dart';

class WorkCategory extends Model {
    WorkCategory({
    required super.id,
    required this.name
  });

  factory WorkCategory.fromJson(final Map<String, dynamic> json) {
    return WorkCategory(
      id: json['Id'],
      name: json['Name']
    );
  }

  final String name;
}
