import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('agenda.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuario (
        id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        telefone TEXT NOT NULL,
        tipo TEXT NOT NULL DEFAULT 'aluno',
        senha TEXT NOT NULL,
        foto TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE aula (
        id_aula INTEGER PRIMARY KEY AUTOINCREMENT,
        id_usuario INTEGER NOT NULL,
        materia TEXT NOT NULL,
        modalidade TEXT NOT NULL,
        frequencia TEXT NOT NULL,
        descricao TEXT NOT NULL,
        dia_aula TEXT NOT NULL,
        horario_inicio TEXT NOT NULL,
        horario_fim TEXT NOT NULL,
        metodo_pagamento TEXT NOT NULL,
        momento_pagamento TEXT NOT NULL,
        FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}