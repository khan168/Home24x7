import 'package:flutter/cupertino.dart';
import 'package:home24x7/framework/viewModel.dart';

import 'mixInDescricao.dart';

abstract class ViewModelLista<O extends MixInDescricao> extends ViewModel {
  final List<O> listaVisivel;
  final List<O> listaCompleta;
  final TextEditingController controlerFieldPesquisa = TextEditingController();

  ViewModelLista({
    required this.listaVisivel,
    required this.listaCompleta,
  });

  void aplicaFiltroDePesquisa() {
    this.listaVisivel.clear();
    String argumentoDePesquisa = this.controlerFieldPesquisa.text.toUpperCase().trim();
    if (argumentoDePesquisa.isEmpty) {
      this.listaVisivel.addAll(this.listaCompleta);
    } else {
      this.listaCompleta.forEach((objetoDaLista) {
        String descricaoBusinessModel = objetoDaLista.getDescricao().toUpperCase();
        if (descricaoBusinessModel.contains(argumentoDePesquisa)) {
          this.listaVisivel.add(objetoDaLista);
        }
      });
    }
  }
}
