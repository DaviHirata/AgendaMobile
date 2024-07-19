import 'package:flutter/material.dart';
import 'package:agenda/screens/HomePageAluno.dart';
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/MeuPerfil.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/AgendarAula.dart';
import 'package:agenda/model/Usuario.dart';

const List<String> list = ['Aluno', 'Meu Perfil', 'Sair'];

class VerAgenda extends StatelessWidget {
  final Usuario usuario;
  final _formKey = GlobalKey<FormState>();

  VerAgenda({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ver Agenda',
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                height: 65,
                width: 65,
              ),
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
              ListTileTheme(
                  child: DropdownButtonExample(usuario: usuario)
              ),
            ],
          ),
        ),
        body: Container(
          color: Color(0xff00ffa3),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Agenda da professora',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  _buildCard('21-06-2024', '07:30:00', '08:30:00'),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SizedBox(width: 70,),
                      Container(
                        height: 60,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Color(0xff00ffa3),
                            border: Border.all(color: Colors.white, width: 4.0),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Fechar o Drawer
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AgendarAula(usuario: usuario)),
                            );
                          },
                          child: const Text(
                            'Agendar aula',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Color(0xff00ffa3),
                            border: Border.all(color: Colors.white, width: 4.0),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Fechar o Drawer
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePageAluno(usuario: usuario)),
                            );
                          },
                          child: const Text(
                            'Voltar',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String date, String startTime, String endTime) {
    return Card(
      color: Color(0xffbee5eb),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data/Dia: $date',
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            SizedBox(height: 8),
            Text(
              'Início da aula: $startTime',
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            SizedBox(height: 8),
            Text(
              'Fim da aula: $endTime',
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ],
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