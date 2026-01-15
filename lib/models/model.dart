/// Classe base para modelos do domínio.
///
/// Define uma identidade comum para todas as entidades.
abstract class Model {
  /// Cria uma instância do modelo com o identificador informado.
  const Model({required this.id});

  /// Identificador único da entidade.
  final int id;
}
