import 'package:hive/hive.dart';
part 'endereco.g.dart';

@HiveType(typeId: 2)
class Endereco extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? endereco;
  @HiveField(2)
  String? numero;
  @HiveField(3)
  String? cep;
  @HiveField(4)
  String? bairro;
  @HiveField(5)
  String? cidade;
  @HiveField(6)
  String? estado;
  @HiveField(7)
  String? complemento;
  @HiveField(8)
  String? referencia;

  Endereco(this.id, this.endereco, this.numero, this.cep, this.bairro,
      this.cidade, this.estado, this.complemento, this.referencia);

  Endereco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endereco = json['endereco'];
    numero = json['numero'];
    cep = json['cep'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    complemento = json['complemento'];
    referencia = json['referencia'];
  }
}
