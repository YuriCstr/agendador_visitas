import 'package:agendador_visitas/src/controller/cliente_controller.dart';
import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/ui/widgets/clientes_widget.dart';
import 'package:agendador_visitas/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientesPage extends StatelessWidget {
  ClientesPage({Key? key}) : super(key: key);
  final controller = Get.put(ClienteController());

  @override
  Widget build(BuildContext context) {
    DatabaseHelper.instance.getClientes();
    return Scaffold(
      body: Obx(
        () => controller.loading.value == true
            ? LoadingWidget()
            : controller.clientList.isEmpty
                ? Center(
                    child: Text(
                      "Você não possui nenhum cliente cadastrado",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                        children: controller.clientList.map((cliente) {
                      return ClientesWidget(cliente: cliente);
                    }).toList()),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          controller.clearController();
          Get.toNamed("/novo_cliente");
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
