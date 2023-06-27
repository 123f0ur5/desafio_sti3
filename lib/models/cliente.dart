import 'package:hive/hive.dart';
part 'cliente.g.dart';

@HiveType(typeId: 1)
class Cliente extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? cnpj;
  @HiveField(2)
  String? cpf;
  @HiveField(3)
  String? nome;
  @HiveField(4)
  String? razaoSocial;
  @HiveField(5)
  String? email;
  @HiveField(6)
  DateTime? dataNascimento;

  Cliente(this.id, this.cnpj, this.cpf, this.nome, this.razaoSocial, this.email,
      this.dataNascimento);

  Cliente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cnpj = json['cnpj'];
    cpf = json['cpf'];
    nome = json['nome'];
    razaoSocial = json['razaoSocial'];
    email = json['email'];
    dataNascimento = DateTime.parse(json['dataNascimento']);
  }
}
