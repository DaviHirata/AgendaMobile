import 'package:agenda/screens/LoginAluno.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/controller/usuario_controller.dart';
import 'package:agenda/model/usuario.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = UsuarioController();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repetirSenhaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  File? _imagem;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Tirar foto'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _imagem = File(image.path); // Atualiza o estado com a imagem tirada
                    });
                  }
                  Navigator.pop(context); // Fecha o menu após a seleção
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Escolher foto'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imagem = File(image.path); // Atualiza o estado com a imagem selecionada
                    });
                  }
                  Navigator.pop(context); // Fecha o menu após a seleção
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 65, width: 65),
            SizedBox(width: 10),
            Text('Prof.ª Janaina'),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff0c7650),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Fechar o Drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text(
                  'Início',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Preços'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Precos()),
                );
              },
            ),
            ListTile(
              title: Text('Sobre a Professora'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sobre()),
                );
              },
            ),
            ListTile(
              title: Text('Entrar'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginAluno()),
                );
              },
            ),
            ListTile(
              title: Text('Cadastrar'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cadastro()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xff00ffa3),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _nomeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome completo',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _senhaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _repetirSenhaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value != _senhaController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Repetir senha',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _telefoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Número de celular',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      if (_imagem != null)
                        Image.file(
                          _imagem!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: _pickImage,
                        child: Text(
                          _imagem == null ? 'Escolher foto' : 'Trocar foto',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 75,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(0xff00ffa3),
                    border: Border.all(color: Colors.white, width: 5.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Usuario usuario = Usuario(
                          nome: _nomeController.text,
                          email: _emailController.text,
                          telefone: _telefoneController.text,
                          senha: _senhaController.text,
                          foto: _imagem?.path,
                        );

                        try {
                          await _usuarioController.cadastrarUsuario(
                            usuario.nome,
                            usuario.email,
                            usuario.telefone,
                            usuario.senha,
                            foto: usuario.foto, // Passe o caminho da foto para o controlador
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Usuário cadastrado com sucesso!'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => loginAluno()),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao cadastrar usuário: $e'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já possui uma conta?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => loginAluno()),
                          );
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}