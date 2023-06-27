import 'package:desafio_sti3/models/cliente.dart';
import 'package:desafio_sti3/models/endereco.dart';
import 'package:desafio_sti3/models/item.dart';
import 'package:desafio_sti3/models/pagamento.dart';
import 'package:desafio_sti3/models/pedido.dart';
import 'package:flutter/material.dart';
import 'config/hive_config.dart';
import 'views/tela_pedidos.dart';
import 'views/tela_inicio.dart';
import 'views/tela_relatorios.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:desafio_sti3/widgets/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  Hive.registerAdapter(PedidoAdapter());
  await Hive.openBox("pedidos");
  Hive.registerAdapter(ClienteAdapter());
  await Hive.openBox("clientes");
  Hive.registerAdapter(EnderecoAdapter());
  await Hive.openBox("enderecos");
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox("itens");
  Hive.registerAdapter(PagamentoAdapter());
  await Hive.openBox("pagamentos");
  Get.put(NavBarController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const TelaInicio(),
      getPages: [
        GetPage(name: '/tela_inicio', page: () => const TelaInicio()),
        GetPage(name: '/tela_pedido', page: () => const TelaPedidos()),
        GetPage(name: '/tela_relatorio', page: () => const TelaRelatorios()),
      ],
    );
  }
}
