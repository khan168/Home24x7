import 'package:home24x7/framework/viewBuilder.dart';
import 'viewActionsPerfilPrestadorDeServico.dart';
import 'viewPerfilPrestadorDeServico.dart';
import 'viewModelPerfilPrestadorDeServico.dart';

class ViewBuilderPerfilPrestadorDeServico extends ViewBuilder<
    ViewPerfilPrestadorDeServico,
    ViewModelPerfilPrestadorDeServico,
    ViewActionsPerfilPrestadorDeServico> {
  @override
  ViewPerfilPrestadorDeServico createView(
      ViewModelPerfilPrestadorDeServico? viewModel,
      ViewActionsPerfilPrestadorDeServico viewActions) {
    return ViewPerfilPrestadorDeServico(
      viewModel: viewModel,
      viewActions: viewActions,
    );
  }
}
