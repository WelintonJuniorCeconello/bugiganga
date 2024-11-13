import 'package:bugiganga/FIRESTORE/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PageFirestore extends StatefulWidget {
  const PageFirestore({super.key});

  @override
  State<PageFirestore> createState() => _PageFirestoreState();
}

class _PageFirestoreState extends State<PageFirestore> {
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextFormField(
                  controller: _text,
                  decoration: const InputDecoration(),
                ),
              ),
              ElevatedButton(
                onPressed: () => FirestoreApi().addDB(
                    Colecao.cidades,
                    _text.text.trim(),
                    Cidade(
                      nome: _text.text.trim(),
                      estado: 'Teste2',
                      ddi: 12,
                      regioes: [],
                    )),
                child: const Text("Adicionar"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () =>
                    FirestoreApi().deleteDocDB([_text.text.trim()]),
                child: const Text("Deletar"),
              ),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cidades')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return ListView(
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['nome']),
                            );
                          })
                          .toList()
                          .cast(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
