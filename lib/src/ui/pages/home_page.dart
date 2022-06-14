import 'package:agendador_visitas/src/controller/home_controller.dart';
import 'package:agendador_visitas/src/ui/pages/clientes_page.dart';
import 'package:agendador_visitas/src/ui/pages/rota_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "AgendeJá",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.purple,
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              labelPadding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Rotas"),
                Tab(text: "Clientes"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RotaPage(),
              ClientesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
