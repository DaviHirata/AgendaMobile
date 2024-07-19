import 'package:agenda/database/DatabaseHelper.dart';
import 'package:agenda/model/Aula.dart';

class AulaDAO {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final String tableAula = 'aula';

  Future<List<Aula>> buscarAulasDoUsuario(int? usuarioId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final List<Map<String, dynamic>> maps = await db.query(
        tableAula,
        where: 'id_usuario = ?',
        whereArgs: [usuarioId],
      );

      return List.generate(maps.length, (i) {
        return Aula(
          idAula: maps[i]['id_aula'],
          idUsuario: maps[i]['id_usuario'],
          materia: maps[i]['materia'],
          modalidade: maps[i]['modalidade'],
          frequencia: maps[i]['frequencia'],
          descricao: maps[i]['descricao'],
          diaAula: maps[i]['dia_aula'],
          horarioInicio: maps[i]['horario_inicio'],
          horarioFim: maps[i]['horario_fim'],
          metodoPagamento: maps[i]['metodo_pagamento'],
          momentoPagamento: maps[i]['momento_pagamento'],
        );
      });
    } catch (e) {
      throw Exception('Erro ao buscar as aulas do usuário: $e');
    }
  }

  Future<int> createAula(Aula aula) async {
    final db = await databaseHelper.database;
    return await db.insert('aula', aula.toMap());
  }

  Future<List<Aula>> getAulas() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('aula');

    return List.generate(maps.length, (i) {
      return Aula.fromMap(maps[i]);
    });
  }

  Future<Aula?> getAulaById(int? idAula) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('aula', where: 'id_aula = ?', whereArgs: [idAula]);

    if (maps.isNotEmpty) {
      return Aula.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateAula(Aula aula) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'aula',
      aula.toMap(),
      where: 'id_aula = ?',
      whereArgs: [aula.idAula],
    );
  }

  Future<int> deleteAula(Aula aula) async {
    final db = await databaseHelper.database;
    return await db.delete(
      'aula',
      where: 'id_aula = ?',
      whereArgs: [aula.idAula],
    );
  }
}
