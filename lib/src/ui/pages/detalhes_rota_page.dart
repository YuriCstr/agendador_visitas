import 'package:agendador_visitas/src/controller/rota_controller.dart';
import 'package:agendador_visitas/src/ui/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetalhesRotaPage extends StatelessWidget {
  DetalhesRotaPage({Key? key}) : super(key: key);
  final controller = Get.put(RotaController());

  @override
  Widget build(BuildContext context) {
    var newFormat = DateFormat("d MMM y");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Detalhes da Rota"),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "A data prevista para essa rota é: " +
                    newFormat.format(controller.rota.value.dataPrevista!),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: controller.rota.value.clientesDaRota!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[700],
                      child: Icon(
                        Icons.person_outline_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "${controller.rota.value.clientesDaRota![index].nome} ${controller.rota.value.clientesDaRota![index].telefone}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "${controller.rota.value.clientesDaRota![index].logradouro}, ${controller.rota.value.clientesDaRota![index].numero}, ${controller.rota.value.clientesDaRota![index].cep}, ${controller.rota.value.clientesDaRota![index].uf}",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      controller.rota.value.clientesDaRota![index].status == 1
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      Text("Selecione uma tag para o cliente"),
                                  content: StatusWidget(
                                    clienteId: controller
                                        .rota.value.clientesDaRota![index].id!,
                                    rotaId: controller.rota.value.id!,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text("Cancelar"),
                                    ),
                                  ],
                                );
                              },
                            )
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Uma tag ja foi selecionada"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text("Cancelar"),
                                    ),
                                  ],
                                );
                              },
                            );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
