import 'package:flutter/material.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/LoginAluno.dart';
import 'package:agenda/screens/Cadastro.dart';
import 'package:agenda/screens/LoginAluno.dart';
import 'dart:ui';

class HomePage extends StatelessWidget {
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
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Container(
                height: 75,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 5.0), borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  //LoginAluno - HomePageAluno
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => loginAluno()));
                  },
                  child: const Text(
                    'Agendar aula',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}