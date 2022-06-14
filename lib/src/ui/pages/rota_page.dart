import 'package:agendador_visitas/src/controller/cliente_controller.dart';
import 'package:agendador_visitas/src/controller/rota_controller.dart';
import 'package:agendador_visitas/src/controller/tag_controller.dart';
import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/model/rota.dart';
import 'package:agendador_visitas/src/ui/widgets/loading_widget.dart';
import 'package:agendador_visitas/src/ui/widgets/rotas_widget.dart';
import 'package:agendador_visitas/src/ui/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RotaPage extends StatelessWidget {
  final controller = Get.put(RotaController());
  final clienteController = Get.put(ClienteController());
  RotaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Rota>>(
        future: DatabaseHelper.instance.getRotas(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingWidget());
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text(
                    "Você não possui nenhuma rota cadastrada",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                      children: snapshot.data!.map((rota) {
                    return RotasWidget(rota: rota);
                  }).toList()),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          DatabaseHelper.instance.getTags();
          final tagCon = Get.put(TagController());
          if (tagCon.tags.length == 0) {
            tagCon.createTags();
          }
          controller.clearController();
          clienteController.clientList.isEmpty
              ? showSnackBar(
                  "Atenção",
                  "É necessário cadastrar pelo menos 1 cliente antes",
                  Colors.red)
              : Get.toNamed('/nova_rota');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
