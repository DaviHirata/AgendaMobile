import 'package:agenda/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/HomePageAluno.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/Cadastro.dart';
import 'package:agenda/controller/usuario_controller.dart';
import 'dart:ui';

class loginAluno extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _usuarioController = UsuarioController(); // instancia o controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 65, width: 65,),
            SizedBox(width: 10,),
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
                    MaterialPageRoute(builder: (context) => Precos()));
              },
            ),
            ListTile(
              title: Text('Sobre a Professora'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sobre()));
              },
            ),
            ListTile(
              title: Text('Entrar'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginAluno()));
              },
            ),
            ListTile(
              title: Text('Cadastrar'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cadastro()));
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
                SizedBox(height: 20,),
                Text(
                  'Entre na sua conta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child:  TextFormField(
                    controller: _emailController,
                    validator: (valor){
                      if(valor == null || valor.isEmpty){
                        return 'Digite um email válido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Insira seu email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child:  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    validator: (valor){
                      if(valor == null || valor.isEmpty){
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        hintText: 'Insira sua senha'),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 75,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 5.0), borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        // Aqui você faz a validação do login
                        String email = _emailController.text;
                        String senha = _senhaController.text;

                        try {
                          // Chama o método do controlador para validar o login
                          Usuario? loggedIn = await _usuarioController.loginUsuario(email, senha);

                          if (loggedIn != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => HomePageAluno(usuario: loggedIn)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email ou senha incorretos.'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao fazer login: $e'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text('Não tem uma conta ainda?', style: TextStyle(fontWeight: FontWeight.bold),),
                      TextButton(
                          onPressed: (){
                            Navigator.push( context, MaterialPageRoute(builder: (_) => Cadastro()));
                          },
                          child: Text('Crie sua conta',
                            style:  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          )
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}