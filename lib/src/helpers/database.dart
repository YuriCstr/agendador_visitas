import 'package:agendador_visitas/src/controller/cliente_controller.dart';
import 'package:agendador_visitas/src/controller/rota_controller.dart';
import 'package:agendador_visitas/src/controller/tag_controller.dart';
import 'package:agendador_visitas/src/model/cliente.dart';
import 'package:agendador_visitas/src/model/rota.dart';
import 'package:agendador_visitas/src/model/tag.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'agendaJa.db');
    return await openDatabase(
      path,
      version: 6,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cliente(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codigo INTEGER,
        nome TEXT,
        cpfCnpj TEXT,
        logradouro TEXT,
        numero TEXT,
        cep TEXT,
        cidade TEXT,
        uf TEXT,
        telefone TEXT,
        status INTEGER,
        isSelect BOOLEAN NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE rotas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        dataPrevista TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tag(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE clientesRota(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clienteId INTEGER,
        rotaId INTEGER,
        marcacaoId INTEGER,
        FOREIGN KEY (marcacaoId) REFERENCES tag (id),
        FOREIGN KEY (clienteId) REFERENCES cliente (id),
        FOREIGN KEY (rotaId) REFERENCES rotas (id)
      )
    ''');
  }

  Future<List<Cliente>> getClientes() async {
    Database db = await instance.database;
    var clientes = await db.query('cliente', orderBy: 'id');
    final controller = Get.put(ClienteController());
    List<Cliente> clienteList = clientes.isNotEmpty
        ? clientes.map((c) => Cliente.fromMap(c)).toList()
        : [];
    controller.clientList.value = clienteList;
    return clienteList;
  }

  Future<int> addCliente(Cliente cliente) async {
    Database db = await instance.database;
    return await db.insert('cliente', cliente.toMap());
  }

  Future<int> addRota(Rota rota) async {
    Database db = await instance.database;
    return await db.insert('rotas', rota.toMap());
  }

  Future<List<Rota>> getRotas() async {
    Database db = await instance.database;
    var rotas = await db.query('rotas');
    final controller = Get.put(RotaController());
    List<Rota> rotaList =
        rotas.isNotEmpty ? rotas.map((r) => Rota.fromMap(r)).toList() : [];
    controller.rotaList.value = rotaList;
    return rotaList;
  }

  Future<int> addTags(Tag tag) async {
    Database db = await instance.database;
    return await db.insert('tag', tag.toMap());
  }

  Future<List<Tag>> getTags() async {
    Database db = await instance.database;
    var tags = await db.query('tag');
    final controller = Get.put(TagController());
    List<Tag> tagList =
        tags.isNotEmpty ? tags.map((t) => Tag.fromMap(t)).toList() : [];
    controller.tags.value = tagList;
    if (tagList.isEmpty) controller.createTags();
    return tagList;
  }

  Future<int> addReferences(Cliente cliente) async {
    Database db = await instance.database;
    var rotas = await db.query('rotas');
    List<Rota> rotasList = rotas.map((r) => Rota.fromMap(r)).toList();
    return await db.insert('clientesRota', {
      "clienteId": cliente.id,
      "rotaId": rotasList.last.id,
      "marcacaoId": 1
    });
  }

  getDetailRota(Rota rota) async {
    Database db = await instance.database;
    List<Map> map = await db.rawQuery(
        'SELECT c.id, c.codigo, c.nome, c.cpfCnpj, c.telefone, c.logradouro, c.numero, c.cep, c.cidade, c.uf, t.id as status FROM cliente as c INNER JOIN clientesRota as r ON c.id = r.clienteId INNER JOIN tag as t ON t.id = r.marcacaoId WHERE r.rotaId =${rota.id}');
    List<Cliente> clienteList = clienteFromMap(map);
    final controller = Get.put(RotaController());
    controller.rota.value = Rota(
        id: rota.id,
        dataPrevista: rota.dataPrevista,
        clientesDaRota: clienteList);
  }

  updateClienteTag(int marcacaoId, int clienteId, int rotaId) async {
    Database db = await instance.database;
    await db.rawUpdate(
        'UPDATE clientesRota SET marcacaoId = ? WHERE clienteId = ? AND rotaId = ?',
        [marcacaoId, clienteId, rotaId]);
  }
}
