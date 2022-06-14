import 'package:agendador_visitas/src/controller/tag_controller.dart';
import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/model/rota.dart';
import 'package:agendador_visitas/src/ui/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusWidget extends StatelessWidget {
  final int clienteId;
  final Rota rota;
  StatusWidget({Key? key, required this.clienteId, required this.rota})
      : super(key: key);
  final controller = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatus(Colors.green, "Visita realizada", 2),
        _buildStatus(Colors.brown[300]!, "Cliente ausente", 3),
        _buildStatus(
            Colors.deepOrange[300]!, "Visita cancelada pelo cliente", 4),
      ],
    );
  }

  _buildStatus(Color color, String titulo, int statusId) {
    return InkWell(
      onTap: () {
        controller.loading.value = true;
        DatabaseHelper.instance.updateClienteTag(statusId, clienteId, rota.id!);
        DatabaseHelper.instance.getDetailRota(rota);
        Get.back();
        controller.loading.value = false;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 3),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(
          titulo,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
