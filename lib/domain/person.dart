import 'model.dart';

/// Representa uma pessoa no sistema.
class Person extends Model {
  /// Cria uma instância de [Person].
  Person(
    super.id,
    this.name,
    this.cpf,
    this.phoneNumber,
    this.cep,
    this.pictureUrl,
  );

  /// Cria uma instância de [Person] a partir de um JSON.
  factory Person.fromJson(final Map<String, dynamic> json) {
    return Person(
      json['Id'],
      json['Name'],
      json['Cpf'],
      json['PhoneNumber'],
      json['Cep'],
      json['PictureUrl'],
    );
  }

  /// Nome da pessoa.
  final String name;

  /// CPF da pessoa.
  final String cpf;

  /// Número de telefone para contato.
  final String phoneNumber;

  /// CEP do endereço da pessoa.
  final String cep;

  /// URL da imagem de perfil da pessoa.
  final String pictureUrl;
}
