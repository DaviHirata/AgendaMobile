import 'package:agenda/controller/Aula_Controller.dart';
import 'package:agenda/model/Aula.dart';
import 'package:agenda/model/Usuario.dart';
import 'package:agenda/screens/EditarAgendamento.dart';
import 'package:agenda/screens/HomePageAluno.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screens/HomePage.dart';
import 'package:agenda/screens/Sobre.dart';
import 'package:agenda/screens/Precos.dart';
import 'package:agenda/screens/Cadastro.dart';
import 'package:agenda/screens/MeuPerfil.dart';
import 'dart:ui';

const List<String> frequenciaList = ['Semanalmente'];
const List<String> diaAulaList = ['Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira'];
const List<String> list = <String>['Aluno', 'Meu Perfil', 'Sair'];
const List<String> Modalidade = ['Presencial', 'Remoto'];
const List<String> FrequenciaAula = ['Aula única', 'Duas aulas (em sequência)', 'Semanalmente'];
const List<String> Pagamento = ['PIX', 'Dinheiro'];
const List<String> Momento = ['Final da aula', 'Início do mês', 'Final do mês'];

enum Materia { matematica, ingles }

class AgendarAula extends StatefulWidget {
  final Usuario usuario;

  AgendarAula({required this.usuario});

  @override
  _AgendarAulaState createState() => _AgendarAulaState();
}

class _AgendarAulaState extends State<AgendarAula> {
  final _formKey = GlobalKey<FormState>();
  final AulaController _aulaController = AulaController();

  Materia? _materia = Materia.matematica;
  String _modalidade = Modalidade.first;
  String _frequencia = FrequenciaAula.first;
  String _diaAula = diaAulaList.first;
  String _pagamento = Pagamento.first;
  String _momento = Momento.first;
  TimeOfDay _horarioInicio = TimeOfDay(hour: 10, minute: 30);
  TimeOfDay _horarioFim = TimeOfDay(hour: 11, minute: 30);
  TextEditingController _descricaoController = TextEditingController();

  Future<void> _selectTime(BuildContext context, bool isInicio) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isInicio ? _horarioInicio : _horarioFim,
    );
    if (picked != null) {
      setState(() {
        if (isInicio) {
          _horarioInicio = picked;
        } else {
          _horarioFim = picked;
        }
      });
    }
  }

  void _saveAula() async {
    if (_formKey.currentState!.validate()) {
      final aula = Aula(
        idUsuario: widget.usuario.id ?? 0,
        materia: _materia.toString().split('.').last,
        modalidade: _modalidade,
        descricao: _descricaoController.text,
        frequencia: _frequencia,
        diaAula: _diaAula,
        horarioInicio: _horarioInicio.format(context),
        horarioFim: _horarioFim.format(context),
        metodoPagamento: _pagamento,
        momentoPagamento: _momento,
      );

      int id = await _aulaController.createAula(aula);
      if (id > 0) {
        // Navega para a próxima página apenas se a operação for bem-sucedida
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageAluno(usuario: widget.usuario)),
        );
      } else {
        // Tratar erro de salvamento aqui, caso necessário
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Erro ao salvar aula'),
            content: Text('Não foi possível salvar a aula. Tente novamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

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
                child: DropdownButtonExample(usuario: widget.usuario)
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
                SizedBox(height: 40,),
                Text(
                  'Agendar aula',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                MateriaRadio(onChanged: (value) {
                  setState(() {
                    _materia = value;
                  });
                }),
                DropdownModalidade(onChanged: (value) {
                  setState(() {
                    _modalidade = value!;
                  });
                }),
                Padding(
                  padding: EdgeInsets.all(15),
                  child:  TextFormField(
                    controller: _descricaoController,
                    validator: (valor){
                      if(valor == null || valor.isEmpty){
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Conteúdos que deseja estudar',
                        hintText: ''),
                  ),
                ),
                DropdownFrequenciaAula(onChanged: (value) {
                  setState(() {
                    _frequencia = value!;
                  });
                }),
                DropdownDiaSemana(onChanged: (value) {
                  setState(() {
                    _diaAula = value!;
                  });
                }),
                TimePickerInicio(
                  selectedTime: _horarioInicio,
                  onSelectTime: (picked) {
                    setState(() {
                      _horarioInicio = picked;
                    });
                  },
                ),
                TimePickerFim(
                  selectedTime: _horarioFim,
                  onSelectTime: (picked) {
                    setState(() {
                      _horarioFim = picked;
                    });
                  },
                ),
                DropdownPagamento(onChanged: (value) {
                  setState(() {
                    _pagamento = value!;
                  });
                }),
                DropdownMomento(onChanged: (value) {
                  setState(() {
                    _momento = value!;
                  });
                }),
                Row(
                  children: [
                    SizedBox(width: 115,),
                    Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Color(0xff00ffa3), border: Border.all(color: Colors.white, width: 4.0), borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: _saveAula,
                        child: const Text(
                          'Salvar',
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
                              MaterialPageRoute(builder: (context) => HomePageAluno(usuario: widget.usuario)));
                        },
                        child: const Text(
                          'Voltar',
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
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

class MateriaRadio extends StatefulWidget {
  final ValueChanged<Materia?> onChanged;

  MateriaRadio({required this.onChanged});

  @override
  _MateriaRadioState createState() => _MateriaRadioState();
}

class _MateriaRadioState extends State<MateriaRadio> {
  Materia? _materia = Materia.matematica;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListTile(
                title: const Text('Matemática'),
                leading: Radio<Materia>(
                  value: Materia.matematica,
                  groupValue: _materia,
                  onChanged: (Materia? value) {
                    setState(() {
                      _materia = value;
                    });
                    widget.onChanged(value);
                  },
                ),
            )
          ),
          Expanded(
            child: ListTile(
              title: const Text('Inglês'),
              leading: Radio<Materia>(
                value: Materia.ingles,
                groupValue: _materia,
                onChanged: (Materia? value) {
                  setState(() {
                    _materia = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          )
      ],
    );
  }
}

class DropdownModalidade extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  DropdownModalidade({required this.onChanged});

  @override
  _DropdownModalidadeState createState() => _DropdownModalidadeState();
}

class _DropdownModalidadeState extends State<DropdownModalidade> {
  String dropdownValue = Modalidade.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Modalidade'
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: Modalidade.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}

class DropdownFrequenciaAula extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  DropdownFrequenciaAula({required this.onChanged});

  @override
  _DropdownFrequenciaAulaState createState() => _DropdownFrequenciaAulaState();
}

class _DropdownFrequenciaAulaState extends State<DropdownFrequenciaAula> {
  String dropdownValue = FrequenciaAula.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Frequência'
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: FrequenciaAula.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}

class DropdownDiaSemana extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  DropdownDiaSemana({required this.onChanged});

  @override
  _DropdownDiaSemanaState createState() => _DropdownDiaSemanaState();
}

class _DropdownDiaSemanaState extends State<DropdownDiaSemana> {
  String dropdownValue = diaAulaList.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Dia da aula'
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: diaAulaList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}

class TimePickerInicio extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onSelectTime;

  TimePickerInicio({required this.selectedTime, required this.onSelectTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );
          if (picked != null && picked != selectedTime) {
            onSelectTime(picked);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hora de Início: ${selectedTime.format(context)}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Icon(Icons.access_time, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class TimePickerFim extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onSelectTime;

  TimePickerFim({required this.selectedTime, required this.onSelectTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );
          if (picked != null && picked != selectedTime) {
            onSelectTime(picked);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hora de Fim: ${selectedTime.format(context)}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Icon(Icons.access_time, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownPagamento extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  DropdownPagamento({required this.onChanged});

  @override
  _DropdownPagamentoState createState() => _DropdownPagamentoState();
}

class _DropdownPagamentoState extends State<DropdownPagamento> {
  String dropdownValue = Pagamento.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Método de Pagamento'
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: Pagamento.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}

class DropdownMomento extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  DropdownMomento({required this.onChanged});

  @override
  _DropdownMomentoState createState() => _DropdownMomentoState();
}

class _DropdownMomentoState extends State<DropdownMomento> {
  String dropdownValue = Momento.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Momento do Pagamento'
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: Momento.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}