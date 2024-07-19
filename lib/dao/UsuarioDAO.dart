import '../database/DatabaseHelper.dart';
import '../model/Usuario.dart';

class UsuarioDao {
  Future<int> createUser(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('usuario', usuario.toMap());
  }

  Future<Usuario?> getUserByEmail(String email) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'usuario',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getAllUsers() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('usuario');

    return result.map((json) => Usuario.fromMap(json)).toList();
  }

  Future<void> updateUser(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id_usuario = ?',
      whereArgs: [usuario.id],
    );
  }
}