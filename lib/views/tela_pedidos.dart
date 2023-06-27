import 'package:flutter/material.dart';
import 'package:desafio_sti3/controllers/fetch_data.dart';
import 'package:hive/hive.dart';
import 'package:desafio_sti3/widgets/card.dart';
import 'package:desafio_sti3/models/pedido.dart';
import 'package:desafio_sti3/models/cliente.dart';
import 'package:desafio_sti3/models/endereco.dart';
import 'package:desafio_sti3/models/item.dart';
import 'package:desafio_sti3/models/pagamento.dart';
import 'package:desafio_sti3/widgets/navbar.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({Key? key}) : super(key: key);
  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

TextEditingController txtQuery = TextEditingController();

Box boxPedidos = Hive.box("pedidos");
Box boxClientes = Hive.box("clientes");
Box boxEnderecos = Hive.box("enderecos");
Box boxItens = Hive.box("itens");
Box boxPagamentos = Hive.box("pagamentos");

class _TelaPedidosState extends State<TelaPedidos> {
  Key? get key => null;

  void darkenPage() {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(0.5),
      ),
    );
    overlayState.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Pedido> listaPedidos = boxPedidos.values.cast<Pedido>().toList();

    if (txtQuery.text.isNotEmpty) {
      listaPedidos = listaPedidos.where((pedido) {
        Cliente cliente = boxClientes.get(pedido.idCliente.toString());
        return cliente.nome
            .toString()
            .toLowerCase()
            .contains(txtQuery.text.toLowerCase());
      }).toList();
    }

    listaPedidos.sort((a, b) => int.parse(a.numero.toString())
        .compareTo(int.parse(b.numero.toString())));

    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 7),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 7, 0),
                    child: TextFormField(
                      controller: txtQuery,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Pesquisar pelo nome",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            txtQuery.text = '';
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  )),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(50, 13, 202, 240)),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: IconButton(
                        icon: const Icon(Icons.sync),
                        onPressed: () async {
                          txtQuery.text = "";
                          darkenPage();
                          await fetchDataAndPopulateHive();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaPedidos.length,
                itemBuilder: (context, index) {
                  Pedido pedido = listaPedidos[index];
                  Cliente cliente =
                      boxClientes.get(pedido.idCliente.toString());
                  Endereco endereco =
                      boxEnderecos.get(pedido.idEnderecoEntrega.toString());
                  List<Item> itens = [];
                  List<Pagamento> pagamentos = [];

                  for (var i in pedido.idItens) {
                    Item item = boxItens.get(i);
                    itens.add(item);
                  }
                  for (var p in pedido.idPagamento) {
                    Pagamento pagamento = boxPagamentos.get(p);
                    pagamentos.add(pagamento);
                  }
                  return PedidoCard(
                      key, pedido, cliente, endereco, itens, pagamentos);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
