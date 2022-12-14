import '../framework/mixInDescricao.dart';
import '../framework/businessModel.dart';

class BusinessModelCidade extends BusinessModel with MixInDescricao {
  final int codCidade;
  final String nome;
  final int totalPrestadoresServico;

  BusinessModelCidade({
    required this.codCidade,
    required this.nome,
    required this.totalPrestadoresServico,
  }) : super(id: codCidade.toString());

  factory BusinessModelCidade.vazio() => BusinessModelCidade(codCidade: 0, nome: '', totalPrestadoresServico: 0);

  factory BusinessModelCidade.Todos() => BusinessModelCidade(codCidade: 999999, nome: 'Todos', totalPrestadoresServico: 0);

  String getDescricao() {
    return nome;
  }
}

