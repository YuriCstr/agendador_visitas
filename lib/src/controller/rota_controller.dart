import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/model/cliente.dart';
import 'package:agendador_visitas/src/model/rota.dart';
import 'package:agendador_visitas/src/ui/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RotaController extends GetxController {
  final rotaList = <Rota>[].obs;
  final clientesSelecionados = <Cliente>[].obs;
  final rota = Rota().obs;
  DateTime? dateTime;

  bool validateRota() {
    if (dateTime != null && clientesSelecionados.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearController() {
    dateTime = null;
    clientesSelecionados.value = [];
  }

  void createRota() async {
    DatabaseHelper.instance.addRota(
      Rota(nome: "#", dataPrevista: dateTime),
    );
    for (var cliente in clientesSelecionados) {
      await DatabaseHelper.instance.addReferences(cliente);
    }
    Get.back();
    showSnackBar("Sucesso", "Rota criada com sucesso", Colors.green);
  }

  void atualizarSelecionados(List<Cliente> clientes) {
    var selectClientes = clientes.where((element) => element.isSelect == true);
    selectClientes.any((element) => element.isSelect = false);
  }

  void reorder(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = clientesSelecionados.removeAt(oldIndex);
    clientesSelecionados.insert(newIndex, items);
  }
}
