import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:home24x7/businessModels/businessModelCidade.dart';
import 'package:home24x7/businessModels/businessModelPrincipaisTiposDeServicoCidade.dart';
import 'package:home24x7/businessModels/businessModelTiposDeServico.dart';
import 'package:home24x7/framework/bloc.dart';
import 'package:home24x7/provider/principaisTiposDeServicoCidade/providerPrincipaisTiposDeServicoCidade.dart';
import '../../provider/cidade/providerCidade.dart';
import '../../provider/tiposDeServico/providerTiposDeServico.dart';
import 'blocEventHub.dart';
import 'viewModelHub.dart';

class BlocHub extends Bloc<ViewModelHubUsuario, BlocEventHubUsuario> {
  @override
  void onReceiveBlocEvent(BlocEventHubUsuario blocEvent) {
    if (blocEvent is BlocEventHubInicializaViewModelUsuario)
      _inicializaViewModel(blocEvent);
    if (blocEvent is BlocEventHubSelecionaCidade) _selecionaCidade(blocEvent);
    if (blocEvent is BlocEventHubUsuarioAtualizaViewModel)
      _atualizaViewModel(blocEvent);
  }

/*  Future<ViewModelHubUsuario> _aplicaCidadeNoViewModel(BusinessModelDadosUsuario Usuario, String idCidade) async {
    BusinessModelPrincipaisTiposDeServicoCidade principaisTiposDeServicoCidade = await ProviderPrincipaisTiposDeServicoCidade().getBusinessModel(idCidade);
    print(principaisTiposDeServicoCidade);

    ViewModelHubUsuario viewModel = ViewModelHubUsuario(
      Usuario: Usuario,
      cidade: principaisTiposDeServicoCidade.cidade,
      principaisTiposDeServicoCidade: principaisTiposDeServicoCidade,
    );
    return viewModel;
  }*/

  void _inicializaViewModel(
      BlocEventHubInicializaViewModelUsuario blocEvent) async {
    String idCidadeDoUsuario = "1"; // 1=colatina


    Future<List<BusinessModelCidade> > getCidades() async {
      List<BusinessModelCidade> listaDeTodasAsCidades = [];

      listaDeTodasAsCidades = await ProviderCidade().getBusinessModels();
      return listaDeTodasAsCidades;
    }

    List<BusinessModelCidade> cidades = await getCidades();

    BusinessModelPrincipaisTiposDeServicoCidade
        principaisTiposDeServicoCidades =
        await ProviderPrincipaisTiposDeServicoCidade().getBusinessModel(cidades[0].id);

    ViewModelHubUsuario viewModelTmp = ViewModelHubUsuario(
      cidade: cidades[0],
      principaisTiposDeServicoCidade: principaisTiposDeServicoCidades,
    );
    this.sendViewModelOut(viewModelTmp);

    ViewModelHubUsuario viewModel =
        await _aplicaCidadeNoViewModel(idCidadeDoUsuario);
    this.sendViewModelOut(viewModel);
  }

  Future<List<BusinessModelCidade>> getCidades() async {
    List<BusinessModelCidade> listaDeTodasAsCidades = [];

    listaDeTodasAsCidades = await ProviderCidade().getBusinessModels();
    return listaDeTodasAsCidades;
  }

  Future<List<BusinessModelTiposDeServico>> getTiposDeServico() async {
    List<BusinessModelTiposDeServico> listaTodosPrestadores = [];

    listaTodosPrestadores = await ProviderTiposDeServico().getBusinessModels();
    return listaTodosPrestadores;
  }



  void _selecionaCidade(BlocEventHubSelecionaCidade blocEvent) async {
    List<BusinessModelCidade> cidades = await getCidades();

    List<BusinessModelTiposDeServico> tiposDeServico = await getTiposDeServico();

    ViewModelHubUsuario _viewModel = ViewModelHubUsuario(
      cidade: cidades[int.parse(blocEvent.codCidade.toString())],
      principaisTiposDeServicoCidade:
          BusinessModelPrincipaisTiposDeServicoCidade(
              cidade: cidades[int.parse(blocEvent.codCidade.toString())],
              tiposDeServico: tiposDeServico),
    );
    this.sendViewModelOut(_viewModel);

    ViewModelHubUsuario viewModel = await _aplicaCidadeNoViewModel(
      blocEvent.codCidade.toString(),
    );
    this.sendViewModelOut(viewModel);
  }

  Future<ViewModelHubUsuario> _aplicaCidadeNoViewModel(
    String idCidade,
  ) async {
    BusinessModelPrincipaisTiposDeServicoCidade principaisTiposDeServicoCidade =
        await ProviderPrincipaisTiposDeServicoCidade()
            .getBusinessModel(idCidade);
    print(principaisTiposDeServicoCidade);
    ViewModelHubUsuario viewModel = ViewModelHubUsuario(
      cidade: principaisTiposDeServicoCidade.cidade,
      principaisTiposDeServicoCidade: principaisTiposDeServicoCidade,
    );
    return viewModel;
  }

  void _atualizaViewModel(
      BlocEventHubUsuarioAtualizaViewModel blocEvent) async {
    ViewModelHubUsuario viewModelTmp = ViewModelHubUsuario(
      cidade: BusinessModelCidade.vazio(),
      principaisTiposDeServicoCidade:
          BusinessModelPrincipaisTiposDeServicoCidade.vazio(),
    );
    this.sendViewModelOut(viewModelTmp);

    //String urlFoto = await ProviderUsuario().getUrlFotoById(Usuario.id);

    debugPrint(blocEvent.viewModel.cidade.id);

    ViewModelHubUsuario _viewModel =
        await _aplicaCidadeNoViewModel(blocEvent.viewModel.cidade.id);

    ViewModelHubUsuario viewModel = ViewModelHubUsuario(
        cidade: _viewModel.cidade,
        principaisTiposDeServicoCidade:
            _viewModel.principaisTiposDeServicoCidade);
    this.sendViewModelOut(viewModel);
  }
}
