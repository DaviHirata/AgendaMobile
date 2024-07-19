import 'package:agenda/screens/LoginAluno.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Cadastro.dart';

import 'dart:ui';

class Precos extends StatelessWidget {
  const Precos({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preços',
      home: Scaffold(
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
              padding: const EdgeInsets.only(bottom: 16.0, left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Preços',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Color(0xff0c7650),
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        _buildTableRow('Aula', 'Preço (hora-aula)'),
                        _buildTableRow('1 aula', 'R\$60,00'),
                        _buildTableRow('2 aulas', 'R\$55,00'),
                        _buildTableRow('Aulas semanais (1, 2, 3, 4 vezes por semana)', 'R\$60,00*'),
                      ],
                    ),
                  ),
                  Text("*5% de desconto para cada aula a mais.", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String leftText, String rightText) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(leftText, style: TextStyle(color: Colors.white),),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(rightText, style: TextStyle(color: Colors.white),),
          ),
        ),
      ],
    );
  }
}