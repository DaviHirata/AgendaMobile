import 'package:agenda/database/DatabaseHelper.dart';
import 'package:agenda/model/Aula.dart';
import 'package:agenda/dao/AulaDAO.dart';

class AulaController {
  final AulaDAO aulaDAO = AulaDAO();
  final databaseHelper = DatabaseHelper.instance;

  Future<int> createAula(Aula aula) async {
    return await aulaDAO.createAula(aula);
  }

  Future<List<Aula>> getAulas() async {
    return await aulaDAO.getAulas();
  }

  Future<void> atualizarAula(int? idAula, String materia, String descricao, String modalidade, String frequencia, String diaAula, String horarioInicio, String horarioFim, String metodoPagamento, String momentoPagamento) async {
    Aula? aula = await aulaDAO.getAulaById(idAula);
    if (aula != null) {
      aula.materia = materia;
      aula.descricao = descricao;
      aula.modalidade = modalidade;
      aula.frequencia = frequencia;
      aula.diaAula = diaAula;
      aula.horarioInicio = horarioInicio;
      aula.horarioFim = horarioFim;
      aula.metodoPagamento = metodoPagamento;
      aula.momentoPagamento = momentoPagamento;

      await aulaDAO.updateAula(aula);
    } else {
      throw Exception('Aula não encontrada');
    }
  }

  Future<int> deletarAula(Aula aula) async {
    return await aulaDAO.deleteAula(aula);
  }
}