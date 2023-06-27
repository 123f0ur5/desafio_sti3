import 'package:flutter/material.dart';
import 'package:desafio_sti3/widgets/navbar.dart';

class TelaInicio extends StatelessWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/logo.png",
      )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
