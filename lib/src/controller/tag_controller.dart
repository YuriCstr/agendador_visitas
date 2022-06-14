import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/model/tag.dart';
import 'package:get/get.dart';

class TagController extends GetxController {
  final tags = <Tag>[].obs;

  void createTags() async {
    var tagList = <Tag>[
      Tag(id: 1, nome: "Pendente"),
      Tag(id: 2, nome: "Realizada"),
      Tag(id: 3, nome: "Ausente"),
      Tag(id: 4, nome: "Cancelada"),
    ];
    for (var tag in tagList) {
      await DatabaseHelper.instance.addTags(tag);
    }
  }
}
