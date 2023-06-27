import 'package:desafio_sti3/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:desafio_sti3/models/pedido.dart';
import 'package:desafio_sti3/models/cliente.dart';
import 'package:desafio_sti3/models/endereco.dart';
import 'package:desafio_sti3/models/item.dart';
import 'package:desafio_sti3/models/pagamento.dart';

class PedidoCard extends StatefulWidget {
  final Pedido pedido;
  final Cliente cliente;
  final Endereco endereco;
  final List<Item> itens;
  final List<Pagamento> pagamentos;

  const PedidoCard(Key? key, this.pedido, this.cliente, this.endereco,
      this.itens, this.pagamentos)
      : super(key: key);

  @override
  _PedidoCardState createState() => _PedidoCardState();
}

class _PedidoCardState extends State<PedidoCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 6,
          margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text(widget.cliente.nome.toString(),
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        const Divider(indent: 7),
                        Text("#${widget.pedido.numero}",
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey)),
                      ]),
                      Text(
                        dateTimeToDate(widget.pedido.dataCriacao.toString()),
                      ),
                    ]),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.pedido.status.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.pedido.status.toString() == "APROVADO"
                                ? Colors.green
                                : Colors.red,
                          )),
                      Text(
                          dateTimeToTime(widget.pedido.dataCriacao.toString())),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text(
                            "R\$ ${widget.pedido.valorTotal!.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 20)),
                        const Divider(indent: 7),
                        if (widget.pedido.desconto != 0)
                          Container(
                              height: 16,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 214, 45, 45),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              child: Center(
                                  child: Text("-${widget.pedido.desconto}%",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white))))
                      ]),
                      IconButton(
                          onPressed: () =>
                              setState(() => _expanded = !_expanded),
                          icon: Icon(_expanded == false
                              ? Icons.arrow_downward_rounded
                              : Icons.arrow_upward_rounded))
                    ]),
                if (_expanded) ...[
                  const Center(
                      child: Text("Produtos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ))),
                  const Divider(height: 7),
                  Column(children: [
                    for (var item in widget.itens)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Tooltip(
                                    message: item.nome.toString(),
                                    child: Text(
                                      "• ${item.quantidade}x ${item.nome}",
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            SizedBox(
                                width: 105,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("R\$",
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                          "${item.valorUnitario!.toStringAsFixed(2)}/u",
                                          style: const TextStyle(fontSize: 16)),
                                    ]))
                          ])
                  ]),
                  const Divider(height: 14),
                  const Center(
                      child: Text("Parcelas",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ))),
                  const Divider(height: 7),
                  Column(children: [
                    for (var item in widget.pagamentos)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Tooltip(
                                    message: item.nome.toString(),
                                    child: Text(
                                      "• ${item.parcela}ª Parcela",
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            SizedBox(
                                width: 105,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("R\$",
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                          "${item.valor!.toStringAsFixed(2)}/u",
                                          style: const TextStyle(fontSize: 16)),
                                    ]))
                          ])
                  ]),
                  const Divider(height: 14),
                  ElevatedButton(
                      onPressed: () {
                        consultarPedido(context, widget.pedido, widget.endereco,
                            widget.cliente);
                      },
                      child: const Text(
                        "Consultar Pedido",
                        style: TextStyle(fontSize: 16),
                      ))
                ]
              ])),
        ),
      ],
    );
  }
}

void consultarPedido(
    BuildContext context, Pedido pedido, Endereco endereco, Cliente cliente) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        content: SingleChildScrollView(
            child: Column(children: [
          Container(
              width: double.infinity,
              color: const Color.fromARGB(50, 13, 202, 240),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info),
                    SizedBox(width: 8),
                    Text('Informações do Pedido',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Text("Número: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(pedido.numero.toString())
                ]),
                Row(children: [
                  const Text("Data criação: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(dateTimeFormatada(pedido.dataCriacao.toString()))
                ]),
                Row(children: [
                  const Text("Data alteração: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(dateTimeFormatada(pedido.dataAlteracao.toString()))
                ]),
                Row(children: [
                  const Text("Status: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(pedido.status.toString())
                ]),
                Row(children: [
                  const Text("Desconto:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(pedido.desconto!.toStringAsFixed(2))
                ]),
                Row(children: [
                  const Text("Frete:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(pedido.frete!.toStringAsFixed(2))
                ]),
                Row(children: [
                  const Text("Subtotal: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(pedido.subTotal!.toStringAsFixed(2))
                ]),
                Row(children: [
                  const Text("Total: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(pedido.valorTotal!.toStringAsFixed(2))
                ]),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              color: const Color.fromARGB(50, 13, 202, 240),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('Informações do Cliente',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Text("Cliente: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(cliente.nome.toString())
                ]),
                Row(children: [
                  const Text("Documento: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(cliente.cpf.toString())
                ]),
                Row(children: [
                  const Text("Data nascimento: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(dateTimeToDate(cliente.dataNascimento.toString()))
                ]),
                Row(children: [
                  const Text("Email: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(cliente.email.toString())
                ]),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              color: const Color.fromARGB(50, 13, 202, 240),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.house),
                    SizedBox(width: 8),
                    Text('Local de Entrega',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Text("Endereço: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.endereco.toString())
                ]),
                Row(children: [
                  const Text("Número: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.numero.toString())
                ]),
                Row(children: [
                  const Text("Bairro: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.bairro.toString())
                ]),
                Row(children: [
                  const Text("Cidade: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.cidade.toString())
                ]),
                Row(children: [
                  const Text("Estado: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.estado.toString())
                ]),
                Row(children: [
                  const Text("CEP: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.cep.toString())
                ]),
                Row(children: [
                  const Text("Complemento: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.complemento.toString())
                ]),
                Row(children: [
                  const Text("Referência: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(endereco.referencia.toString())
                ]),
              ],
            ),
          ),
        ])),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}
