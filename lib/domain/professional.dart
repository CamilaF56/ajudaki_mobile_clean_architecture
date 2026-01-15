import 'person.dart';

class Professional extends Person {
  Professional({
    required super.id,
    required super.name,
    required super.cpf,
    required super.phoneNumber,
    required super.cep,
    required super.pictureUrl
  });

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
