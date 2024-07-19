import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Adicione esta importação
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/MeuPerfil.dart';
import 'package:agenda/model/Usuario.dart';
import 'package:agenda/controller/Usuario_Controller.dart';

const List<String> list = <String>['Meu Perfil', 'Sair'];

class EditarPerfil extends StatefulWidget {
  final Usuario usuario;

  EditarPerfil({required this.usuario});

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  late TextEditingController _telefoneController;
  File? _imagem; // Variável para armazenar a imagem
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario.nome);
    _emailController = TextEditingController(text: widget.usuario.email);
    _senhaController = TextEditingController(text: widget.usuario.senha);
    _telefoneController = TextEditingController(text: widget.usuario.telefone);
    if (widget.usuario.foto != null && widget.usuario.foto!.isNotEmpty) {
      _imagem = File(widget.usuario.foto!);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

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

  void _salvarEdicao() async {
    if (_formKey.currentState!.validate()) {
      String nome = _nomeController.text;
      String email = _emailController.text;
      String senha = _senhaController.text;
      String telefone = _telefoneController.text;

      UsuarioController usuarioController = UsuarioController();

      try {
        await usuarioController.atualizarUsuario(
          widget.usuario,
          nome,
          email,
          senha,
          telefone,
          foto: _imagem?.path,
        );

        // Atualiza o objeto 'usuario' com os novos dados
        widget.usuario.nome = nome;
        widget.usuario.email = email;
        widget.usuario.senha = senha;
        widget.usuario.telefone = telefone;
        widget.usuario.foto = _imagem?.path;

        // Retorna à tela de perfil após salvar
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MeuPerfil(usuario: widget.usuario)),
        );
      } catch (e) {
        // Tratar erro de atualização aqui, se necessário
        print('Erro ao atualizar usuário: $e');
      }
    }
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
                  Navigator.pop(context);
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Precos()),
                );
              },
            ),
            ListTile(
              title: Text('Sobre a Professora'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sobre()),
                );
              },
            ),
            ListTileTheme(
              child: DropdownButtonExample(usuario: widget.usuario),
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
                SizedBox(height: 40),
                Text(
                  'Edite sua conta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _nomeController,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome completo',
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _senhaController,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _telefoneController,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Número de celular',
                      hintText: '',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 115),
                    Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xff28a745),
                        border: Border.all(color: Colors.white, width: 4.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: _salvarEdicao,
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xff00ffa3),
                        border: Border.all(color: Colors.white, width: 4.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MeuPerfil(usuario: widget.usuario),
                            ),
                          );
                        },
                        child: const Text(
                          'Voltar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  final Usuario usuario;

  const DropdownButtonExample({super.key, required this.usuario});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      padding: EdgeInsets.only(left: 16),
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        if (value == 'Meu Perfil') {
          Navigator.pop(context); // Fechar o Drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeuPerfil(usuario: widget.usuario)),
          );
        } else if (value == 'Sair') {
          Navigator.pop(context); // Fechar o Drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return list.map<Widget>((String value) {
          return Text(
            value == list[0] ? widget.usuario.nome : value,
            style: TextStyle(color: Colors.black, fontSize: 16),
          );
        }).toList();
      },
    );
  }
}