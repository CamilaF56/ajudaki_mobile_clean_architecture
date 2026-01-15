import 'model.dart';
import 'work_category.dart';

class WorkType extends Model {
    WorkType({
    required super.id,
    required this.name,
    required this.workCategory
  });

  factory WorkType.fromJson(final Map<String, dynamic> json) {
    return WorkType(
      id: json['Id'],
      name: json['Name'],
      workCategory: WorkCategory.fromJson(json['WorkCategory'])
    );
  }

  final String name;
  final WorkCategory? workCategory;
}
