import 'person.dart';

/// Representa um profissional no sistema.
///
/// Especializa a entidade [Person].
class Professional extends Person {
  /// Cria uma instância de [Professional].
  Professional({
    required super.id,
    required super.name,
    required super.cpf,
    required super.phoneNumber,
    required super.cep,
    required super.pictureUrl,
  });

  /// Cria uma instância de [Professional] a partir de um JSON.
  ///
  /// Reutiliza o mapeamento definido em [Person].
  factory Professional.fromJson(final Map<String, dynamic> json) {
    final person = Person.fromJson(json);

    return Professional(
      id: person.id,
      name: person.name,
      cpf: person.cpf,
      phoneNumber: person.phoneNumber,
      cep: person.cep,
      pictureUrl: person.pictureUrl,
    );
  }
}
