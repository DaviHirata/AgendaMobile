import 'package:flutter/material.dart';
import 'package:agenda/screens/AgendarAula.dart';
import 'package:agenda/screens/HomePageAluno.dart';
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/MeuPerfil.dart';
import 'package:agenda/screens/EditarAgendamento.dart';
import 'package:agenda/model/Usuario.dart';
import 'package:agenda/model/Aula.dart';
import 'package:agenda/dao/AulaDAO.dart';
import 'package:agenda/controller/Aula_Controller.dart';

const List<String> list = <String>['Aluno', 'Meu Perfil', 'Sair'];

class MeusAgendamentos extends StatelessWidget {
  final Usuario usuario;
  final AulaDAO aulaDAO = AulaDAO();
  final AulaController aulaController = AulaController();

  MeusAgendamentos({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Aula>>(
      future: aulaDAO.buscarAulasDoUsuario(usuario.id), // Busca as aulas do usuário
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar as aulas'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                  ListTileTheme(
                    child: DropdownButtonExample(usuario: usuario),
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
                        'Meus Agendamentos',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          title: Text(
                            'Nenhuma aula encontrada',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Você ainda não tem agendamentos.'),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          SizedBox(width: 50,),
                          Container(
                            height: 60,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 4.0), borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Fechar o Drawer
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AgendarAula(usuario: usuario)),
                                );
                              },
                              child: const Text(
                                'Novo agendamento',
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 60,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 4.0), borderRadius: BorderRadius.circular(20)),
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
          );
        } else {
          List<Aula> aulas = snapshot.data!;
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
                  ListTileTheme(
                    child: DropdownButtonExample(usuario: usuario),
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
                        'Meus Agendamentos',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: aulas.length,
                          itemBuilder: (BuildContext context, int index) {
                            Aula aula = aulas[index];
                            return _buildCard(
                              context,
                              aula.materia,
                              aula.frequencia,
                              aula.modalidade,
                              aula.diaAula,
                              aula.horarioInicio,
                              aula.horarioFim,
                              'Pendente',
                              EditarAgendamento(usuario: usuario, aulaEditar: aula),
                              aula,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          SizedBox(width: 50,),
                          Container(
                            height: 60,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 4.0), borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Fechar o Drawer
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AgendarAula(usuario: usuario)),
                                );
                              },
                              child: const Text(
                                'Novo agendamento',
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 60,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 4.0), borderRadius: BorderRadius.circular(20)),
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
          );
        }
      },
    );
  }

  Widget _buildCard(BuildContext context, String materia, String frequencia, String tipoAula, String dia, String inicio, String fim, String status, Widget page, Aula aula) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        title: Text(
          '$materia - $tipoAula - $frequencia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dia da aula: $dia'),
            Text('Início: $inicio'),
            Text('Fim: $fim'),
            Text('Status: $status'),
            SizedBox(height: 10),
            Row(
              children: [
                _buildButton(context, 'Editar', page, Color(0xff007bff)),
                SizedBox(width: 10,),
                _deleteButton(context, 'Deletar', aula, Color(0xffc82333)),
              ]
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Widget page, Color color) {
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context); // Fechar o Drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 9.0),
        ),
      ),
    );
  }
  Widget _deleteButton(BuildContext context, String label, Aula aula, Color color) {
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: () async {
          await aulaController.deletarAula(aula);
          Navigator.pop(context); // Fechar o Drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeusAgendamentos(usuario: usuario)),
          );
        },
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 9.0),
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