import 'model.dart';

class Person extends Model {
    Person({
    required super.id,
    required this.name,
    required this.cpf,
    required this.phoneNumber,
    required this.cep,
    required this.pictureUrl
  });

  factory Person.fromJson(final Map<String, dynamic> json) {
    return Person(
      id: json['Id'],
      name: json['Name'],
      cpf: json['Cpf'],
      phoneNumber: json['PhoneNumber'],
      cep: json['Cep'],
      pictureUrl: json['PictureUrl'],
    );
  }

  final String name;
  final String cpf;
  final String phoneNumber;
  final String cep;
  final String pictureUrl;
}
