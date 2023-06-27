// import 'dart:collection';

// import 'package:hive/hive.dart';
// import 'package:desafio_sti3/models/pedido.dart';

// class PedidosRepository{
//   List<Pedido> _list = [];

//   late Box openBoxPedido;

//   PedidosRepository(){
//     _startRepository();
//   }

//   _startRepository() async {
//     await _openBox();
//     await _readPedidos();
//   }

//   _openBox() async {
//     Hive.registerAdapter(PedidoAdapter());
//     await Hive.openBox<Pedido>('pedidos');
//   }

//   _readPedidos() async{
//     for(var key in openBoxPedido.keys){
//       Pedido p = await openBoxPedido.get(key);
//       _list.add(p);
//       print(p);
//     }
//   }

//   add(Pedido p) {

//     Box box = Hive.box<Pedido>("pedidos");
//     box.add(p);
//   }

//   UnmodifiableListView<Pedido> get list => UnmodifiableListView(_list);
// }
