import 'package:agendador_visitas/src/controller/rota_controller.dart';
import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/model/rota.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RotasWidget extends StatelessWidget {
  final Rota rota;
  RotasWidget({Key? key, required this.rota}) : super(key: key);
  final controller = Get.put(RotaController());

  @override
  Widget build(BuildContext context) {
    var newFormat = DateFormat("d MMM y");

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          DatabaseHelper.instance.getDetailRota(rota);
          Get.toNamed('/rota_detalhes');
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rota ${rota.nome} ${rota.id! + 1000}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Data prevista: " + newFormat.format(rota.dataPrevista!),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
