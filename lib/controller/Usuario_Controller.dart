import 'package:agenda/dao/UsuarioDAO.dart';
import 'package:agenda/model/Usuario.dart';

class UsuarioController {
  final UsuarioDao usuarioDao = UsuarioDao();

  Future<void> cadastrarUsuario(String nome, String email, String telefone, String senha, {String? foto}) async {
    if (await usuarioDao.getUserByEmail(email) != null) {
      throw Exception('Email já está em uso');
    }

    final usuario = Usuario(
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
      foto: foto,
    );

    // Persistência local
    await usuarioDao.createUser(usuario);
  }

  Future<Usuario> loginUsuario(String email, String senha) async {
    Usuario? usuario = await usuarioDao.getUserByEmail(email);

    if (usuario?.senha == senha) {
      if (usuario != null) {
        return usuario; // retorna o usuário se estiver ativo
      } else {
        throw Exception('Usuário inativo ou inadimplente');
      }
    } else {
      throw Exception('Email ou senha incorretos');
    }
  }

  Future<void> atualizarUsuario(Usuario usuarioLogado, String nome, String email, String senha, String telefone, {String? foto}) async {
    Usuario? usuario = await usuarioDao.getUserByEmail(usuarioLogado.email);

    if (usuario != null) {
      // Atualiza os campos necessários no objeto de usuário
      usuario.nome = nome;
      usuario.email = email;
      usuario.senha = senha; // Você pode querer adicionar validações aqui
      usuario.telefone = telefone;
      usuario.foto = foto;

      // Persistência local
      await usuarioDao.updateUser(usuario);
    } else {
      throw Exception('Usuário não encontrado'); // Trate esse caso conforme sua lógica de negócio
    }
  }
}