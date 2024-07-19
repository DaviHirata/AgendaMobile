import 'package:agenda/screens/LoginAluno.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/Cadastro.dart';
import 'package:agenda/screens/HomePage.dart';
import 'dart:ui';

class Sobre extends StatelessWidget {
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                'Conheça a professora',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                Image.asset('assets/images/prof.jpg'),
                SizedBox(height: 20,),
                Text('Meu nome é Janaina e sou apaixonada por ensinar '
                      'matemática e inglês. Com 44 anos de idade e '
                      'vasta experiência, leciono ambas as disciplinas '
                      'em aulas particulares.', style: TextStyle(fontSize: 18,),),
              ],
            ),
          ),
        ),
      )
    );
  }
}