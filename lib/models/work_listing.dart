import 'model.dart';
import 'professional.dart';
import 'work_type.dart';

/// Representa um anúncio de trabalho.
class WorkListing extends Model {
  /// Cria uma instância de [WorkListing].
  WorkListing({
    required super.id,
    required this.title,
    required this.description,
    required this.estimatedPrice,
    this.workType,
    this.professional,
  });

  /// Cria uma instância de [WorkListing] a partir de um JSON.
  factory WorkListing.fromJson(final Map<String, dynamic> json) {
    return WorkListing(
      id: json['Id'],
      title: json['Title'],
      description: json['Description'],
      estimatedPrice: json['EstimatedPrice'],
      workType: WorkType.fromJson(json['WorkType']),
      professional: Professional.fromJson(json['Professional']),
    );
  }

  /// Título do anúncio de trabalho.
  final String title;

  /// Descrição detalhada do serviço oferecido.
  final String description;

  /// Valor estimado do serviço.
  final int estimatedPrice;

  /// Tipo de trabalho associado ao anúncio.
  final WorkType? workType;

  /// Profissional responsável pelo serviço.
  final Professional? professional;
}
