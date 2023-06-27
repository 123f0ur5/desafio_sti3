import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 3)
class Item extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? idProduto;
  @HiveField(2)
  String? nome;
  @HiveField(3)
  num? quantidade;
  @HiveField(4)
  num? valorUnitario;

  Item(this.id, this.idProduto, this.nome, this.quantidade, this.valorUnitario);

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduto = json['idProduto'];
    nome = json['nome'];
    quantidade = json['quantidade'];
    valorUnitario = json['valorUnitario'];
  }
}
