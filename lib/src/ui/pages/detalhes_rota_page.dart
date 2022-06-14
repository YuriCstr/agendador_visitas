import 'package:agendador_visitas/src/controller/rota_controller.dart';
import 'package:agendador_visitas/src/controller/tag_controller.dart';
import 'package:agendador_visitas/src/ui/widgets/loading_widget.dart';
import 'package:agendador_visitas/src/ui/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetalhesRotaPage extends StatelessWidget {
  DetalhesRotaPage({Key? key}) : super(key: key);
  final controller = Get.put(RotaController());
  final tagController = Get.put(TagController());

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
        () => tagController.loading.value == true
            ? LoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "A data prevista para essa rota é: " +
                          newFormat.format(controller.rota.value.dataPrevista!),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 15),
                    Expanded(
                        child: ListView.builder(
                      itemCount: controller.rota.value.clientesDaRota!.length,
                      itemBuilder: (context, index) {
                        Color? color;
                        String? status;
                        switch (controller
                            .rota.value.clientesDaRota![index].status) {
                          case 1:
                            color = const Color(0xFFE85365);
                            status = "Pendente";
                            break;
                          case 2:
                            color = const Color(0xFFF5BD0E);
                            status = "Visita realizada";
                            break;
                          case 3:
                            color = const Color(0xFF20C9A4);
                            status = "Cliente ausente";
                            break;
                          case 4:
                            color = const Color(0xFF9D6DFF);
                            status = "Cancelado pelo cliente";
                            break;
                        }
                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: ListTile(
                                    title: Text(
                                      "${controller.rota.value.clientesDaRota![index].nome} ${controller.rota.value.clientesDaRota![index].telefone}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
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
                                      controller
                                                  .rota
                                                  .value
                                                  .clientesDaRota![index]
                                                  .status ==
                                              1
                                          ? showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Selecione uma tag para o cliente"),
                                                  content: StatusWidget(
                                                    clienteId: controller
                                                        .rota
                                                        .value
                                                        .clientesDaRota![index]
                                                        .id!,
                                                    rota: controller.rota.value,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.back(),
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
                                                  title: Text(
                                                      "Uma tag ja foi selecionada"),
                                                  content: Text(
                                                      "Status atual: " +
                                                          status!),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      child: Text("Voltar"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                    },
                                  ),
                                ),
                              ),
                              status == "Pendente"
                                  ? Container()
                                  : Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: color!, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Center(
                                          child: Text(
                                        status!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                            ],
                          ),
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
