
import '../businessModels/businessModelCidade.dart';
import '../provider/cidade/providerCidade.dart';

class Cidades {
  static final Cidades _singleton = Cidades._internal();
  List<BusinessModelCidade> listaDeTodasAsCidades = [];

  factory Cidades() {
    return _singleton;
  }

  Future<void> getCidades() async {
    listaDeTodasAsCidades = await ProviderCidade().getBusinessModels();
    print(listaDeTodasAsCidades.length + 100000000);

  }

  Cidades._internal();
}
