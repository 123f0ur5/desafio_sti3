import 'package:hive/hive.dart';
part 'pedido.g.dart';

@HiveType(typeId: 0)
class Pedido extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? numero;
  @HiveField(2)
  DateTime? dataCriacao;
  @HiveField(3)
  DateTime? dataAlteracao;
  @HiveField(4)
  String? status;
  @HiveField(5)
  num? desconto;
  @HiveField(6)
  num? frete;
  @HiveField(7)
  num? subTotal;
  @HiveField(8)
  num? valorTotal;
  @HiveField(9)
  String? idCliente;
  @HiveField(10)
  String? idEnderecoEntrega;
  @HiveField(11)
  List<String> idItens = [];
  @HiveField(12)
  List<String> idPagamento = [];

  Pedido(
      this.id,
      this.numero,
      this.dataCriacao,
      this.dataAlteracao,
      this.status,
      this.desconto,
      this.frete,
      this.subTotal,
      this.valorTotal,
      this.idCliente,
      this.idEnderecoEntrega,
      this.idItens,
      this.idPagamento);

  Pedido.fromJson(Map<String, dynamic> json) {
    List<String> itens = [];

    for (var ele in json["itens"]) {
      itens.add(ele["id"]);
    }

    List<String> pagamentos = [];
    for (var ele in json["pagamento"]) {
      pagamentos.add(ele["id"]);
    }

    id = json['id'];
    numero = json['numero'];
    dataCriacao = DateTime.parse(json['dataCriacao']);
    dataAlteracao = DateTime.parse(json['dataAlteracao']);
    status = json['status'];
    desconto = json['desconto'];
    frete = json['frete'];
    subTotal = json['subTotal'];
    valorTotal = json['valorTotal'];
    idCliente = json["cliente"]["id"];
    idEnderecoEntrega = json["enderecoEntrega"]["id"];
    idItens = itens;
    idPagamento = pagamentos;
  }
}
