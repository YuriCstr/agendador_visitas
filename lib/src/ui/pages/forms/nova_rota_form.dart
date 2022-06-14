import 'package:agendador_visitas/src/controller/cliente_controller.dart';
import 'package:agendador_visitas/src/controller/rota_controller.dart';
import 'package:agendador_visitas/src/ui/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NovaRotaForm extends StatefulWidget {
  NovaRotaForm({Key? key}) : super(key: key);

  @override
  State<NovaRotaForm> createState() => _NovaRotaFormState();
}

class _NovaRotaFormState extends State<NovaRotaForm> {
  final controller = Get.put(RotaController());
  final clienteController = Get.put(ClienteController());

  var newFormat = DateFormat("d MMM y");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Adicionar uma nova rota"),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.dateTime == null
                    ? "Selecione qual a data que deseja realizar a rota"
                    : "Data prevista: " +
                        newFormat.format(controller.dateTime!),
                style: controller.dateTime == null
                    ? TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
                    : TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: controller.dateTime == null
                                  ? DateTime.now()
                                  : controller.dateTime!,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2050))
                          .then((value) {
                        setState(() {
                          controller.dateTime = value;
                        });
                      });
                    },
                    child: Text(controller.dateTime == null
                        ? "Selecionar data para visita"
                        : "Data prevista: " +
                            newFormat.format(controller.dateTime!))),
              ),
              SizedBox(height: 15),
              Text(
                "Selecione os clientes farão parte dessa rota",
                style: controller.clientesSelecionados.isEmpty
                    ? TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
                    : TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller
                          .atualizarSelecionados(clienteController.clientList);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        clienteController.clientList.length,
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
                                          "${clienteController.clientList[index].nome} ${clienteController.clientList[index].telefone}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                          "${clienteController.clientList[index].logradouro}, ${clienteController.clientList[index].numero}, ${clienteController.clientList[index].cep}, ${clienteController.clientList[index].uf}",
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        trailing: clienteController
                                                .clientList[index].isSelect
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.green[700],
                                              )
                                            : Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.grey,
                                              ),
                                        onTap: () {
                                          setState(() {
                                            clienteController.clientList[index]
                                                    .isSelect =
                                                !clienteController
                                                    .clientList[index].isSelect;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  height: 60,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.clientesSelecionados.value =
                                            clienteController.clientList
                                                .where((clientes) =>
                                                    clientes.isSelect == true)
                                                .toList();
                                      });
                                      Get.back();
                                    },
                                    child: Text("Adiconar clientes"),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                    child: Text("Selecionar clientes")),
              ),
              SizedBox(height: 15),
              Obx(
                () => controller.clientesSelecionados.isEmpty
                    ? Container()
                    : Expanded(
                        child: ReorderableListView(
                          onReorder: (oldIndex, newIndex) {
                            controller.reorder(oldIndex, newIndex);
                          },
                          scrollDirection: Axis.vertical,
                          children: controller.clientesSelecionados
                              .map(
                                (data) => Container(
                                  key: Key('${data.id}'),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.green[700],
                                      child: Icon(
                                        Icons.person_outline_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      "${data.nome} ${data.telefone}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      "${data.logradouro}, ${data.numero}, ${data.cep}, ${data.uf}",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.validateRota()
                          ? controller.createRota()
                          : showSnackBar(
                              "Erro ao criar a rota",
                              "Verifique se preencheu todos os campos",
                              Colors.red);
                    },
                    child: Text("Criar rota")),
              )
            ],
          ),
        ));
  }
}
