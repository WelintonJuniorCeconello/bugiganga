import 'package:cloud_firestore/cloud_firestore.dart';

/// Coleção é a "collection" do banco de dados.
///
/// O nome é o mesmo nome de um objeto (model).
enum Colecao {
  cidades,
}

/// Api para gerenciar banco de dados
class FirestoreApi {
  /// Instancia do banco de dados
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Metodo para adicionar dado especifico no banco.
  Future<void> addDB(Colecao colecao, String doc, dynamic data) async {
    _db
        .collection(colecao.name)
        .withConverter(
            //************************************************************************
            // Adicionar cada objeto diferente aqui.....
            fromFirestore: switch (colecao) {
              Colecao.cidades => Cidade.fromFirestore,
            },
            toFirestore: (Cidade city, options) => switch (colecao) {
                  Colecao.cidades => city.toFirestore(),
                })
        //****************************************************************************
        .doc("${colecao.name}-$doc")
        .set(data);
  }

  /// Metodo para deletar dados no banco
  Future<void> deleteDocDB(List<String> docs) async {
    for (var doc in docs) {
      _db.collection(doc.split('-')[0]).doc(doc).delete();
    }
  }
}

/// Objeto para exemplo da Api Firestore
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
      "estado": estado,
      "ddi": ddi,
      "regioes": regioes,
    };
  }
}
