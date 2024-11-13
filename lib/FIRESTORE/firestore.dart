import 'package:cloud_firestore/cloud_firestore.dart';

enum Colecao {
  cidades,
}

class FirestoreApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDB(Colecao colecao, String doc, dynamic data) async {
    _db
        .collection(colecao.name)
        .withConverter(
            fromFirestore: Cidade.fromFirestore,
            toFirestore: (Cidade city, options) => city.toFirestore())
        .doc(doc)
        .set(data);
  }
}

class Cidade {
  final String nome;
  final String estado;
  final int ddi;
  final List<String> regioes;

  Cidade({
    required this.nome,
    required this.estado,
    required this.ddi,
    required this.regioes,
  });

  factory Cidade.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cidade(
      nome: data?['nome'],
      estado: data?['estado'],
      ddi: data?['ddi'],
      regioes:
          data?['regioes'] is Iterable ? List.from(data?['regioes']) : ['null'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nome": nome,
    };
  }
}
