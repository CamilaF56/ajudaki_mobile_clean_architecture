import 'person.dart';

/// Representa um profissional no sistema.
///
/// Especializa a entidade [Person].
class Professional extends Person {
  /// Cria uma instância de [Professional].
  Professional(
    super.id,
    super.name,
    super.cpf,
    super.phoneNumber,
    super.cep,
    super.pictureUrl,
  );

  /// Cria uma instância de [Professional] a partir de um JSON.
  ///
  /// Reutiliza o mapeamento definido em [Person].
  factory Professional.fromJson(final Map<String, dynamic> json) {
    final person = Person.fromJson(json);

    return Professional(
      person.id,
      person.name,
      person.cpf,
      person.phoneNumber,
      person.cep,
      person.pictureUrl,
    );
  }
}
