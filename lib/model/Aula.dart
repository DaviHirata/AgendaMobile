class Aula {
  int? idAula;
  int idUsuario;
  String materia;
  String modalidade;
  String frequencia;
  String descricao;
  String diaAula;
  String horarioInicio;
  String horarioFim;
  String metodoPagamento;
  String momentoPagamento;

  Aula({
    this.idAula,
    required this.idUsuario,
    required this.materia,
    required this.modalidade,
    required this.frequencia,
    required this.descricao,
    required this.diaAula,
    required this.horarioInicio,
    required this.horarioFim,
    required this.metodoPagamento,
    required this.momentoPagamento,
  });

  // Converte um objeto Aula em um Map
  Map<String, dynamic> toMap() {
    return {
      'id_aula': idAula,
      'id_usuario': idUsuario,
      'materia': materia,
      'modalidade': modalidade,
      'frequencia': frequencia,
      'descricao': descricao,
      'dia_aula': diaAula,
      'horario_inicio': horarioInicio,
      'horario_fim': horarioFim,
      'metodo_pagamento': metodoPagamento,
      'momento_pagamento': momentoPagamento,
    };
  }

  // Converte um Map em um objeto Aula
  factory Aula.fromMap(Map<String, dynamic> map) {
    return Aula(
      idAula: map['id_aula'],
      idUsuario: map['id_usuario'],
      materia: map['materia'],
      modalidade: map['modalidade'],
      frequencia: map['frequencia'],
      descricao: map['descricao'],
      diaAula: map['dia_aula'],
      horarioInicio: map['horario_inicio'],
      horarioFim: map['horario_fim'],
      metodoPagamento: map['metodo_pagamento'],
      momentoPagamento: map['momento_pagamento'],
    );
  }
}
