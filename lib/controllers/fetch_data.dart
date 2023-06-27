import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:desafio_sti3/models/pedido.dart';
import 'package:desafio_sti3/models/pagamento.dart';
import 'package:desafio_sti3/models/cliente.dart';
import 'package:desafio_sti3/models/item.dart';
import 'package:desafio_sti3/models/endereco.dart';

Future<void> fetchDataAndPopulateHive() async {
  final response = await http
      .get(Uri.parse('https://desafiotecnicosti3.azurewebsites.net/pedido'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    Box boxPedido = Hive.box("pedidos");
    Box boxCliente = Hive.box("clientes");
    Box boxEndereco = Hive.box("enderecos");
    Box boxItem = Hive.box("itens");
    Box boxPagamento = Hive.box("pagamentos");

    for (final venda in data) {
      final pedido = Pedido.fromJson(venda);
      final cliente = Cliente.fromJson(venda["cliente"]);
      final endereco = Endereco.fromJson(venda["enderecoEntrega"]);

      for (final produto in venda["itens"]) {
        final item = Item.fromJson(produto);
        boxItem.put(item.id, item);
      }

      for (final parcela in venda["pagamento"]) {
        final pagamento = Pagamento.fromJson(parcela);
        boxPagamento.put(pagamento.id, pagamento);
      }

      boxPedido.put(pedido.id, pedido);
      boxCliente.put(cliente.id, cliente);
      boxEndereco.put(endereco.id, endereco);
    }
  } else {
    throw Exception("Não foi possível fazer o fetch");
  }
}
