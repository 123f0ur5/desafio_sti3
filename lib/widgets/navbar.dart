import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  List<String> paginas = ["tela_inicio", "tela_pedido", "tela_relatorio"];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavBarController>();

    return BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: controller.changePage,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Relatórios',
        ),
      ],
    );
  }
}

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;
  List<String> paginas = ["tela_inicio", "tela_pedido", "tela_relatorio"];

  void changePage(int index) {
    selectedIndex.value = index;
    Get.toNamed(paginas[selectedIndex.value]);
  }
}
