import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/VerAgenda.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Cadastro.dart';
import 'package:agenda/screens/MeuPerfil.dart';
import 'package:agenda/screens/MeusAgendamentos.dart';
import 'package:agenda/screens/AgendarAula.dart';
import 'dart:ui';
import 'package:agenda/model/Usuario.dart';

const List<String> list = <String>['Meu Perfil', 'Sair'];

class HomePageAluno extends StatelessWidget {
  final Usuario usuario;

  HomePageAluno({required this.usuario});

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
            ListTileTheme(
                child: DropdownButtonExample(usuario: usuario)
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
              SizedBox(height: 385,),
              Container(
                height: 75,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 5.0), borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerAgenda(usuario: usuario)));
                  },
                  child: const Text(
                    'Ver agenda',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 75,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 5.0), borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Fechar o Drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgendarAula(usuario: usuario)));
                  },
                  child: const Text(
                    'Novo agendamento',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 75,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 5.0), borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MeusAgendamentos(usuario: usuario)));
                  },
                  child: const Text(
                    'Minhas aulas',
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