import 'package:hive/hive.dart';
part 'pagamento.g.dart';

@HiveType(typeId: 4)
class Pagamento extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  num? parcela;
  @HiveField(2)
  num? valor;
  @HiveField(3)
  String? codigo;
  @HiveField(4)
  String? nome;

  Pagamento(this.id, this.parcela, this.valor, this.codigo, this.nome);

  Pagamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parcela = json['parcela'];
    valor = json['valor'];
    codigo = json['codigo'];
    nome = json['nome'];
  }
}
