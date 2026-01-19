import 'model.dart';

/// Representa um profissional no sistema.
///
/// Especializa a entidade [Professional].
class Professional extends Model {
  /// Cria uma instância de [Professional].
  Professional(
    super.id,
    this.name,
    this.cpf,
    this.phoneNumber,
    this.cep,
    this.pictureUrl,
  );

  /// Cria uma instância de [Professional] a partir de um JSON.
  factory Professional.fromJson(final Map<String, dynamic> json) {
    return Professional(
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
