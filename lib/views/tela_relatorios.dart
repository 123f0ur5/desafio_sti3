import 'package:desafio_sti3/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:desafio_sti3/widgets/navbar.dart';
import 'package:hive/hive.dart';
import 'package:desafio_sti3/models/item.dart';
import 'package:desafio_sti3/models/pedido.dart';
import 'package:desafio_sti3/models/endereco.dart';
import 'package:desafio_sti3/models/cliente.dart';
import 'package:desafio_sti3/models/pagamento.dart';

class TelaRelatorios extends StatefulWidget {
  const TelaRelatorios({super.key});

  @override
  State<TelaRelatorios> createState() => _TelaRelatoriosState();
}

class _TelaRelatoriosState extends State<TelaRelatorios> {
  final _opcoes = [
    "Produtos mais vendidos",
    "Vendas por cidade",
    "Vendas por faixa etária",
    "Vendas por tipo pagamento"
  ];
  String? _escolha;
  List<Widget> result = [];
  bool _started = false;

  Map<String, Map> maisVendidos() {
    Box boxItens = Hive.box("itens");
    List<Item> itens = boxItens.values.cast<Item>().toList();
    Map<String, Map> resultado = {};

    for (Item item in itens) {
      if (resultado.containsKey(item.nome.toString())) {
        resultado[item.nome]?["quantidade"] +=
            int.parse(item.quantidade.toString());
        resultado[item.nome]?["total"] +=
            (double.parse(item.valorUnitario.toString()) *
                double.parse(item.quantidade.toString()));
      } else {
        resultado.addAll({
          item.nome.toString(): {
            "quantidade": item.quantidade,
            "total": (double.parse(item.valorUnitario.toString()) *
                double.parse(item.quantidade.toString()))
          }
        });
      }
    }
    return resultado;
  }

  Map<String, Map> vendasPorCidade() {
    Box boxPedidos = Hive.box("pedidos");
    Box boxEnderecos = Hive.box("enderecos");
    List<Pedido> pedidos = boxPedidos.values.cast<Pedido>().toList();
    Map<String, Map> resultado = {};

    for (Pedido pedido in pedidos) {
      Endereco endereco = boxEnderecos.get(pedido.idEnderecoEntrega);
      if (resultado.containsKey(endereco.cidade.toString())) {
        resultado[endereco.cidade]?["quantidade"] += 1;
        resultado[endereco.cidade]?["total"] +=
            double.parse(pedido.valorTotal.toString());
      } else {
        resultado.addAll({
          endereco.cidade.toString(): {
            "quantidade": 1,
            "total": pedido.valorTotal
          }
        });
      }
    }

    return resultado;
  }

  Map<String, Map> vendasPorFaixaEtaria() {
    Box boxPedidos = Hive.box("pedidos");
    Box boxClientes = Hive.box("clientes");
    List<Pedido> pedidos = boxPedidos.values.cast<Pedido>().toList();
    Map<String, Map> resultado = {
      "18~26": {"quantidade": 0, "total": 0},
      "26~34": {"quantidade": 0, "total": 0},
      "40~60": {"quantidade": 0, "total": 0}
    };

    for (Pedido pedido in pedidos) {
      Cliente cliente = boxClientes.get(pedido.idCliente);
      double idade = (DateTime.now().difference(
                  DateTime.parse(cliente.dataNascimento.toString())))
              .inDays /
          364.floor();

      for (var key in resultado.keys) {
        List<int> range = key.split("~").map(int.parse).toList();
        if (idade >= range[0] && idade <= range[1]) {
          resultado[key]!["quantidade"] += 1;
          resultado[key]!["total"] +=
              double.parse(pedido.valorTotal.toString());
        }
      }
    }

    return resultado;
  }

  Map<String, double> vendaPorTipoPagamento() {
    Box boxPedidos = Hive.box("pedidos");
    Box boxPagamentos = Hive.box("pagamentos");
    List<Pedido> pedidos = boxPedidos.values.cast<Pedido>().toList();
    Map<String, double> resultado = {};

    for (Pedido pedido in pedidos) {
      for (String idPagamento in pedido.idPagamento) {
        Pagamento pagamento = boxPagamentos.get(idPagamento);

        String tipoPagamento = pagamento.nome.toString();
        String dataCompra = dateTimeToDate(pedido.dataCriacao.toString());
        String key = "$dataCompra $tipoPagamento";

        if (resultado.containsKey(key)) {
          resultado[key] =
              (resultado[key] ?? 0) + double.parse(pagamento.valor.toString());
        } else {
          resultado[key] = double.parse(pagamento.valor.toString());
        }
      }
    }

    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    if (_started == false) {
      result.add(nenhumSelecionado());
      _started = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: MediaQuery.of(context).padding.top + 7),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 7, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                      ),
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.only(left: 14),
                        hint: const Text("Selecionar relatório"),
                        value: _escolha,
                        isExpanded: true,
                        items: _opcoes.map(criarOpcao).toList(),
                        onChanged: (value) {
                          setState(() {
                            _escolha = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    result.clear();
                    if (_escolha == "Produtos mais vendidos") {
                      final report = Map.fromEntries(maisVendidos()
                          .entries
                          .toList()
                        ..sort((e1, e2) =>
                            e2.value["total"].compareTo(e1.value["total"])));

                      result
                          .add(linhasCabecalho(["Produto", "Qtde.", "Total"]));
                      report.forEach((key, value) {
                        result.add(linhaRelatorio(
                            [key, value["quantidade"], value["total"]]));
                      });
                    } else if (_escolha == "Vendas por cidade") {
                      final report = Map.fromEntries(vendasPorCidade()
                          .entries
                          .toList()
                        ..sort((e1, e2) =>
                            e2.value["total"].compareTo(e1.value["total"])));

                      result.add(linhasCabecalho(["Cidade", "Qtde.", "Total"]));
                      report.forEach((key, value) {
                        result.add(linhaRelatorio(
                            [key, value["quantidade"], value["total"]]));
                      });
                    } else if (_escolha == "Vendas por faixa etária") {
                      final report = Map.fromEntries(vendasPorFaixaEtaria()
                          .entries
                          .toList()
                        ..sort((e1, e2) =>
                            e2.value["total"].compareTo(e1.value["total"])));

                      result.add(
                          linhasCabecalho(["Faixa Etária", "Qtde.", "Total"]));
                      report.forEach((key, value) {
                        result.add(linhaRelatorio(
                            [key, value["quantidade"], value["total"]]));
                      });
                    } else if (_escolha == "Vendas por tipo pagamento") {
                      final report = Map.fromEntries(
                        vendaPorTipoPagamento().entries.toList()
                          ..sort((e1, e2) => e2.value.compareTo(e1.value)),
                      );

                      result.add(
                          linhasCabecalho(["Data", "Meio pagamento", "Total"]));
                      report.forEach((key, value) {
                        final chaveComposta = key.split(" ");
                        result.add(linhaRelatorio(
                            [chaveComposta[0], chaveComposta[1], value]));
                      });
                    }
                    setState(() {});
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(16))),
                  child: const Text('Filtrar'),
                ),
              ],
            ),
            const Divider(height: 7),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: Column(
                children: [...result],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Row linhasCabecalho(List<String> linhas) {
    TextStyle style = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Row(
      children: [
        const Divider(height: 30),
        Expanded(
          child: Center(
            child: Text(linhas[0], style: style),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(linhas[1], style: style),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(linhas[2], style: style),
          ),
        ),
      ],
    );
  }

  Row linhaRelatorio(List<dynamic> valor) {
    return Row(
      children: [
        const Divider(height: 25),
        Expanded(
          child: Tooltip(
            message: valor[0].toString(),
            child: Text(
              valor[0].toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(valor[1].toString()),
          ),
        ),
        Expanded(
          child: Center(
            child: Text("R\$ ${valor[2].toStringAsFixed(2)}"),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> criarOpcao(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  SizedBox nenhumSelecionado() {
    return const SizedBox(
      height: 100,
      child: Center(
        child: Text(
          "Selecione um relatório.",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
