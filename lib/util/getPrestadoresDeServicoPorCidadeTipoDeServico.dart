import 'package:cloud_firestore/cloud_firestore.dart';

class GetPrestadoresDeServicoPorTipoSeervicoECidade {
  final String idCidade;
  final int idServico;
  GetPrestadoresDeServicoPorTipoSeervicoECidade({required this.idCidade, required this.idServico});

  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<int> action() async {
    QuerySnapshot query = await _instance
        .collection('workers')
        .where('City', arrayContainsAny: [idCidade]).get();

    List docs = query.docs;
    docs.removeWhere((element) {
      return !(element['job'] as List).contains(idServico);
    });

      docs.map( (documentSnapshot) {
        print(documentSnapshot.data());
    });

    return docs.length;
  }
}
